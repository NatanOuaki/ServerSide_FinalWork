using ClassLibrary1.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Server.DTO;
using System.Collections.Generic;
using System.Net;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Server.Controllers
{
    [Route("")]
    [ApiController]
    public class EventsController : ControllerBase
    {

        EventsContext db = new EventsContext();

        // POST /event
        [HttpPost("event")]
        public dynamic PostNewEvent([FromBody] UpdateEventDTO newEvent)
        {
            DateTime sDate, eDate;
            sDate = DateTime.Parse(newEvent.startDate);
            eDate = DateTime.Parse(newEvent.endDate);

            Event e = new Event
            {
                Name = newEvent.title,
                StartDate = sDate,
                EndDate = eDate,
                MaxRegistrations = newEvent.maxRegistrations,
                Location = newEvent.location
            };

            db.Events.Add(e);
            db.SaveChanges();

            return Ok(new { id = e.Id });
        }

        //FIRST ADDED OPTION ----- GET ALL OF THE EVENTS

        // GET /event
        [HttpGet("event")]
        public dynamic GetAllEvents()
        {
            var events = db.Events.Select(x => new
            {
                Id = x.Id,
                Title = x.Name,
                StartDate = x.StartDate,
                EndDate = x.EndDate,
                MaxRegistrations = x.MaxRegistrations,
                Location = x.Location
            }).ToList();
            return Ok(events);
        }

        // GET /event/{id}/registration
        [HttpGet("event/{id}/registration")]
        public dynamic GetEventUsers(string id)
        {
            int intId = int.Parse(id);
            var eve = db.Events.Include(e => e.EventUsers).ThenInclude(x => x.UserRefNavigation).FirstOrDefault(x => x.Id == intId);

            var user = eve.EventUsers.Select(x => new
            {
                Id = x.UserRefNavigation.Id,
                Name = x.UserRefNavigation.Name,
                DateOfBirth = x.UserRefNavigation.DateOfBirth
            }).ToList();


            return Ok(user);
        }


        // POST /event/{id}/registration
        [HttpPost("event/{id}/registration")]
        public dynamic RegisterUserToEvent(string id, [FromBody] AddUserToEventDTO UserToEvent)
        {
            int intId = int.Parse(id);
            DateTime bDate = DateTime.Parse(UserToEvent.DateOfBirth);

            bool isUserRegistered = db.EventUsers.Any(eu => eu.EventRef == intId && db.Users.Any(u => u.Name == UserToEvent.Name && u.DateOfBirth == bDate));
            if (isUserRegistered)
            {
                return BadRequest("User already registered to this event :|"); //code 400
            }

            int MaxRegistrations = db.Events.Where(e => e.Id == intId).First().MaxRegistrations;
            int currentRegistered = db.EventUsers.Count(eu => eu.EventRef == intId);

            if (currentRegistered >= MaxRegistrations)
            {
                return Conflict("The event is full :("); //code 409
            }

            User u = new User
            {
                Name = UserToEvent.Name,
                DateOfBirth = bDate,
            };

            db.Users.Add(u);
            db.SaveChanges();

            EventUser eu = new EventUser
            {
                UserRef = u.Id,
                EventRef = intId,
                Creation = DateTime.Now
            };

            db.EventUsers.Add(eu);
            db.SaveChanges();

            return CreatedAtAction(nameof(RegisterUserToEvent), new { id }, "Added to event successfully :)"); //code 201
        }

        //SECOND ADDED OPTION ----- REMOVE A USER FROM AN EVENT

        // DELETE event/{eventId}/registration/{userId}
        [HttpDelete("event/{eventId}/registration/{userId}")]
        public dynamic DeleteUserFromEvent(string eventId, string userId)
        {
            int eventIdI = int.Parse(eventId);
            int userIdI = int.Parse(userId);

            EventUser eu = db.EventUsers.Where(x => x.EventRef == eventIdI && x.UserRef == userIdI).Single();
            if (eu == null)
                return NotFound("Failed to delete :(");

            db.EventUsers.Remove(eu);
            db.SaveChanges();

            User toDelete = db.Users.Where(x => x.Id == userIdI).Single();
            if (toDelete == null) return NotFound("Failed to delete :(");

            db.Users.Remove(toDelete);
            db.SaveChanges();

            return Ok("User Removed from the event Successfuly :)");
        }


        //THIRD ADDED OPTION ----- GET NUMBER OF REGISTERED TO AN EVENT BY ID

        // GET event/{eventId}/participants
        [HttpGet("event/{id}/participants")]
        public dynamic GetParticipants(string id)
        {
            int idI = int.Parse(id);
            var participantsCount = db.EventUsers.Count(x => x.EventRef == idI);
            return Ok(new { participantsCount = participantsCount });
        }


        // GET event{id}
        [HttpGet("event{id}")]
        public dynamic GetEvent(string id)
        {
            int idI = int.Parse(id);
            Event e = db.Events.Where(x => x.Id == idI).First();
            var e1 = new
            {
                id = e.Id,
                name = e.Name,
                startDate = e.StartDate,
                endDate = e.EndDate,
                location = e.Location,
                GoogleMaps = $"https://www.google.com/maps/search/?api=1&query={e.Location}"
            };
            if (e == null)
                return NotFound("There is no event with this ID :(");
            return Ok(e1);
        }


        // PUT event{id}
        [HttpPut("event{id}")]
        public dynamic UpdateEvent(string id, [FromBody] UpdateEventDTO updateEvent)
        {
            int intId = int.Parse(id);
            Event e = db.Events.FirstOrDefault(x => x.Id == intId);

            if (e == null)
                return NotFound("There is no event with this ID :(");

            DateTime sDate = DateTime.Parse(updateEvent.startDate);
            DateTime eDate = DateTime.Parse(updateEvent.endDate);

            e.Name = updateEvent.title;
            e.StartDate = sDate;
            e.EndDate = eDate;
            e.MaxRegistrations = updateEvent.maxRegistrations;
            e.Location = updateEvent.location;

            db.SaveChanges();

            return Ok("Event updated successfully :)");
        }

        // DELETE event{id}
        [HttpDelete("event{id}")]
        public dynamic DeleteEvent(string id)
        {
            int idI = int.Parse(id);
            var eventToDelete = db.Events.Include(e => e.EventUsers).SingleOrDefault(e => e.Id == idI);

            if (eventToDelete == null)
            {
                return NotFound("Failed to delete: Event not found.");
            }
            db.EventUsers.RemoveRange(eventToDelete.EventUsers);
            db.Events.Remove(eventToDelete);
            db.SaveChanges();
            return Ok("Removed Successfully :)");
        }



        //FOURTH ADDED OPTION ----- GET DATA OF A USER BY ID


        // GET event{id}
        [HttpGet("user{id}")]
        public dynamic GetUser(string id)
        {
            int idI = int.Parse(id);
            User u = db.Users.Where(x => x.Id == idI).First();
            if (u == null)
                return NotFound("There is no event with this ID :(");
            var user = new
            {
                Id = u.Id,
                Name = u.Name,
                DateOfBirth = u.DateOfBirth
            };
            return Ok(user);
        }



        // GET schedule
        [HttpGet("schedule")]
        public dynamic GetEventsSchedule(string startDate, string endDate)
        {
            DateTime sDate, eDate;
            sDate = DateTime.Parse(startDate);
            eDate = DateTime.Parse(endDate);

            var events = db.Events
                .Where(e => e.StartDate >= sDate && e.EndDate <= eDate)
                .Select(e => new {
                    e.Id,
                    e.Name,
                    e.StartDate,
                    e.EndDate
                }).ToList();

            return Ok(events);
        }



        private readonly IMemoryCache _memoryCache;
        public EventsController(IMemoryCache memoryCache)
        {
            _memoryCache = memoryCache;
        }

        // GET /event/{id}/weather
        [HttpGet("event/{id}/weather")]
        public dynamic GetWeather(string id)
        {
            int idI = int.Parse(id);
            Event e = db.Events.Where(x => x.Id == idI).First();
            if (e == null)
            {
                return NotFound("Event not found");
            }

            string location = e.Location;
            string cacheData = _memoryCache.Get<string>($"{location}-cache");
            if (cacheData != null)
            {
                return Content(cacheData, "application/json");
            }

            string json;
            using (WebClient client = new WebClient())
            {
                json = client.DownloadString($"http://api.weatherapi.com/v1/current.json?key=ef8f798b9c664655a7c133632242107&q={location}");
            }

            var expirationTime = DateTimeOffset.Now.AddSeconds(45);
            _memoryCache.Set($"{location}-cache", json, expirationTime);

            return Content(json, "application/json");

        }

    }
}
