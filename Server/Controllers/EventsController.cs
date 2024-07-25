using ClassLibrary1.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using Server.DTO;
using System.Collections.Generic;
using System.Net;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Server.Controllers
{
    [Route("")]
    [ApiController]
    public class EventsController : ControllerBase{

        EventsContext db = new EventsContext();

        // POST /event
        [HttpPost("event")]
        public dynamic PostNewEvent([FromBody] UpdateEventDTO newEvent){
            DateTime startDate, endDate;
            startDate = DateTime.Parse(newEvent.startDate);
            endDate = DateTime.Parse(newEvent.endDate);

            Event e = new Event{
                Name = newEvent.title,
                StartDate = startDate,
                EndDate = endDate,
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
        public dynamic GetAllEvents(){
                List<Event> e = db.Events.ToList();
                if (e.Count == 0){
                    return NotFound("There are no event users with this ID :(");
                }
                return Ok(e);
        }

        
        // GET /event/{id}/registration
        [HttpGet("event/{id}/registration")]
        public dynamic GetEventUsers(string id){
            int intId = int.Parse(id);
            
            var eu = db.EventUsers.Where(x => x.EventRef == intId).Select(x => new{
                x.EventRef,
                x.UserRef,
                x.Creation
            }).ToList();
            
            if (eu.Count == 0){
                return NotFound("There are no event users with this ID :(");
            }
            return Ok(eu);
        }


        // POST /event/{id}/registration
        [HttpPost("event/{id}/registration")]
        public dynamic RegisterUserToEvent(string id, [FromBody] AddUserToEventDTO UserToEvent){
            int intId = int.Parse(id);
            DateTime DateOfBirth = DateTime.Parse(UserToEvent.DateOfBirth);

            List<EventUser> eventUser = db.EventUsers.Where(eu => eu.EventRef == intId).ToList();
            bool userExists = false;
            foreach (var i in eventUser){
                User userRegistered = db.Users.Where(u => i.UserRef == u.Id).First();
                if (userRegistered != null && userRegistered.Name == UserToEvent.Name && userRegistered.DateOfBirth == DateOfBirth)
                        userExists = true;
            }
            if (userExists)
                return BadRequest("User already registered to this event :|"); //code 400

            int MaxRegistrations = db.Events.Where(e => e.Id == intId).First().MaxRegistrations; 
            int currentRegistered = db.EventUsers.Count(eu => eu.EventRef == intId);

            if (currentRegistered >= MaxRegistrations){
                return Conflict("The event is full :("); //code 409
            }

            User u = new User{
                Name = UserToEvent.Name,
                DateOfBirth = DateOfBirth,
            };

            db.Users.Add(u);
            db.SaveChanges();

            EventUser eu = new EventUser{
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
        public dynamic DeleteUserFromEvent(string eventId, string userId){
            int intEventId = int.Parse(eventId);
            int intUserId = int.Parse(userId);

            EventUser eu = db.EventUsers.Where(x => x.EventRef == intEventId && x.UserRef == intUserId).Single();
            if (eu == null)
                return NotFound("Failed to delete :(");

            db.EventUsers.Remove(eu);
            db.SaveChanges();
            return Ok("User Removed from the event Successfuly :)");
        }


        //THIRD ADDED OPTION ----- GET NUMBER OF REGISTERED TO AN EVENT BY ID
        // GET event/{eventId}/participants
        [HttpGet("event/{id}/participants")]
        public dynamic GetParticipants(string id){
            int intId = int.Parse(id);
            var participantsCount = db.EventUsers.Count(x => x.EventRef == intId);
            return Ok(new { participantsCount = participantsCount });
        }


        // GET event{id}
        [HttpGet("event{id}")]
        public dynamic GetEvent(string id){
            int intId = int.Parse(id);
            Event e = db.Events.Where(x => x.Id == intId).First();

            var e1 = new{
                id = e.Id,
                name = e.Name,
                startDate = e.StartDate,
                endDate = e.EndDate,
                maxRegistrations = e.MaxRegistrations,
                location = e.Location,
                GoogleMaps = $"https://www.google.com/maps/search/?api=1&query={e.Location}"
            };
            if (e == null)
                return NotFound("There is no event with this ID :(");
            return Ok(e1);
        }


        // PUT event{id}
        [HttpPut("event{id}")]
        public dynamic UpdateEvent(string id, [FromBody] UpdateEventDTO updateEvent){
            int intId = int.Parse(id);
            Event e = db.Events.FirstOrDefault(x => x.Id == intId);

            if (e == null)
                return NotFound("There is no event with this ID :(");

            DateTime startDate = DateTime.Parse(updateEvent.startDate);
            DateTime endDate = DateTime.Parse(updateEvent.endDate);

            e.Name = updateEvent.title;
            e.StartDate = startDate;
            e.EndDate = endDate;
            e.MaxRegistrations = updateEvent.maxRegistrations;
            e.Location = updateEvent.location;

            db.SaveChanges();

            return Ok("Event updated successfully :)");
        }


        // DELETE event{id}
        [HttpDelete("event{id}")]
        public dynamic DeleteEvent(string id){
            int intId = int.Parse(id);
            var eventToDelete = db.Events.Include(e => e.EventUsers).SingleOrDefault(e => e.Id == intId);

            if (eventToDelete == null){
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
        public dynamic GetUser(string id){
            int intId = int.Parse(id);
            User u = db.Users.Where(x => x.Id == intId).First();
            if (u == null)
                return NotFound("There is no event with this ID :(");
            return Ok(u);
        }


        // GET schedule
        [HttpGet("schedule")]
        public dynamic GetEventsSchedule(string startDate, string endDate){
            DateTime sDate, eDate;
            sDate = DateTime.Parse(startDate);
            eDate = DateTime.Parse(endDate);

            var events = db.Events
                .Where(e => e.StartDate >= sDate && e.EndDate <= eDate)
                .Select(e => new{
                        e.Id,
                        e.Name,
                        e.StartDate,
                        e.EndDate
                    }).ToList();

            return Ok(events);
        }


        private readonly IMemoryCache _memoryCache;
        public EventsController(IMemoryCache memoryCache){
            _memoryCache = memoryCache;
        }

        // GET /event/{id}/weather
        [HttpGet("event/{id}/weather")]
        public dynamic GetWeather(string id){
            int intId = int.Parse(id);
            Event e = db.Events.Where(x => x.Id == intId).First();
            if (e == null){
                return NotFound("Event not found");
            }

            string location = e.Location;
            string cacheData = _memoryCache.Get<string>($"{location}-cache");
            if (cacheData != null){
                return Content(cacheData, "application/json");
            }

            string json;
            using (WebClient client = new WebClient()){
                json = client.DownloadString($"http://api.weatherapi.com/v1/current.json?key=ef8f798b9c664655a7c133632242107&q={location}");
            }

            var expirationTime = DateTimeOffset.Now.AddMinutes(1);
            _memoryCache.Set($"{location}-cache", json, expirationTime);

            return Content(json, "application/json");

        }

    }
}
