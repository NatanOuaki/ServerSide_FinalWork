showAllEvents();


async function getParticipants(id) {
    let url = `http://localhost:5201/event/${id}/participants`;
    try {
        let response = await fetch(url);
        let data = await response.json();
        return data.participantsCount;
    } catch (error) {
        return 0;
    }
}

async function getWeather(id) {
    let url = `http://localhost:5201/event/${id}/weather`;
    try {
        let response = await fetch(url);
        let data = await response.json();
        return data;
    } catch (error) {
        return 0;
    }
}

async function showAllEvents() {
    let url = `http://localhost:5201/event`;

    try {
        let response = await fetch(url);
        let data = await response.json();
        var divEvents = document.getElementById("divEvents");
        let str = "<table id='events'>" +
            "<tr>" +
            "<th>#id</th>" +
            "<th>Name</th>" +
            "<th>Start Date</th>" +
            "<th>End Date</th>" +
            "<th>Number Of Participants</th>" +
            "<th>Max Registration</th>" +
            "<th>Location</th>" +
            "<th>Weather</th>" +
            "</tr>";

        for (let i = 0; i < data.length; i++) {
            let participantsCount = await getParticipants(data[i].id);
            let weather = await getWeather(data[i].id);
            const startDate = new Date(data[i].startDate);
            const formattedStartDate = startDate.toLocaleString('en-GB', {
                year: 'numeric', month: '2-digit', day: '2-digit',
                hour: '2-digit', minute: '2-digit',
                hour12: false
            }).replace(',', '');

            const endDate = new Date(data[i].endDate);
            const formattedEndDate = endDate.toLocaleString('en-GB', {
                year: 'numeric', month: '2-digit', day: '2-digit',
                hour: '2-digit', minute: '2-digit',
                hour12: false
            }).replace(',', '');

            str +=
                `<tr>
                    <td onclick="openModal(${data[i].id})">${data[i].id}</td>
                    <td onclick="openModal(${data[i].id})">${data[i].name}</td>
                    <td onclick="openModal(${data[i].id})">${formattedStartDate}</td>
                    <td onclick="openModal(${data[i].id})">${formattedEndDate}</td>
                    <td onclick="openModal(${data[i].id})">${participantsCount}</td>
                    <td onclick="openModal(${data[i].id})">${data[i].maxRegistrations}</td>
                    <td><a id="regularLink" href="https://www.google.com/maps/search/?api=1&query=${data[i].location}">${data[i].location}</a></td>
                    <td onclick="openWeatherModal(${data[i].id})">
                        <div class="weather">
                            <img class="weatherIcon" src=${weather.current.condition.icon} alt="${weather.current.condition.text} icon">
                            <p>${weather.current.condition.text}</p>
                        </div>
                    </td>
                </tr>`;
        }
        str += "</table>";

        divEvents.innerHTML = str;
    } catch (error) {
        console.error(error);
    }
}


function addEvent() {
    document.getElementById('addEventModal').style.display = 'block';
}

function closeSecondModal() {
    document.getElementById('addEventModal').style.display = 'none';
}

function postNewEvent() {
    const title = document.getElementById('title').value;
    const startDate = document.getElementById('startDate').value;
    const endDate = document.getElementById('endDate').value;
    const maxRegistrations = document.getElementById('maxRegistrations').value;
    const location = document.getElementById('location').value;

    if (title && startDate && endDate && maxRegistrations && location) {
        const eventDetails = {
            title,
            startDate,
            endDate,
            maxRegistrations,
            location
        };

        fetch('http://localhost:5201/event', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(eventDetails)
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => { throw new Error(text); });
                }
                return response.json();
            })
            .then(data => {
                alert('Event successfully added :)');
                closeSecondModal();
                showAllEvents();
                document.getElementById('eventForm').reset();
            })
            .catch(error => {
                console.error('Failed to add event:', error);
                alert('Failed to add event. Please try again.');
            });
    } else {
        alert('Please fill in all fields.');
    }
}


let currentEventId;

function openModal(id) {
    currentEventId = id;
    const modal = document.getElementById("eventModal");
    const modalContent = document.getElementById("modalEventDetails");
    modalContent.innerHTML = ""; 

    let eventUrl = `http://localhost:5201/event/${id}/registration`;

    fetch(eventUrl)
        .then((response) => {
            if (!response.ok) {
                throw new Error(`Error fetching event data: ${response.statusText}`);
            }
            return response.json();
        })
        .then((eventData) => {
            let userPromises = eventData.map((eventItem) => {
                let userUrl = `http://localhost:5201/user${eventItem.userRef}`;
                return fetch(userUrl)
                    .then((response) => {
                        if (!response.ok) {
                            throw new Error(`Error fetching user data: ${response.statusText}`);
                        }
                        return response.json();
                    });
            });

            return Promise.all(userPromises);
        })
        .then((usersData) => {
            let tableHTML = "<table id='eventUsers'>" +
                "<tr>" +
                "<th>#id</th>" +
                "<th>Name</th>" +
                "<th>Birth date</th>" +
                "<th>Remove From Event</th>"
            "</tr>";

            usersData.forEach((user) => {
                const dateOfBirth = new Date(user.dateOfBirth);
                const formattedDateOfBirth = dateOfBirth.toLocaleString('en-GB', {
                    year: 'numeric', month: '2-digit', day: '2-digit',
                }).replace(',', '');

                tableHTML +=
                    `<tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${formattedDateOfBirth}</td>
                        <td><button id="removeUserButton" onclick="deleteFromEvent(${id}, ${user.id})">Remove User</button></td>
                    </tr>`;
            });

            tableHTML += "</table>";
            modalContent.innerHTML = tableHTML;
        })
        .catch((error) => {
            console.error(error);
            modalContent.innerHTML = `<h2><span id="noUserMessage">No user registered to this event...</span></h2>`;
        });

    document.getElementById("deleteButton").setAttribute("data-id", id);
    modal.style.display = "block";
}


function deleteFromEvent(eventId, userId) {
    const url = `http://localhost:5201/event/${eventId}/registration/${userId}`;

    fetch(url, {
        method: 'DELETE',
    })
        .then(response => {
            if (response.ok) {
                alert("User Was Removed From This Event");
                closeModal();
                showAllEvents();
            } else {
                console.error('Failed to delete event');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function deleteEvent() {
    const eventId = document.getElementById("deleteButton").getAttribute("data-id");
    const url = `http://localhost:5201/event${eventId}`;

    fetch(url, {
        method: 'DELETE',
    })
        .then(response => {
            if (response.ok) {
                alert('Event successfully removed :)');
                closeModal();
                showAllEvents();  
            } else {
                console.error('Failed to delete event');
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
}


function closeModal() {
    const modal = document.getElementById("eventModal");
    modal.style.display = "none";
}




function openWeatherModal(id) {
    const weatherModal = document.getElementById("weatherModal");
    const modalWeatherContent = document.getElementById("modalWeatherDetails");
    const weatherModalTitle = document.getElementById("weatherModalTitle");
    modalWeatherContent.innerHTML = "";

    let eventUrl = `http://localhost:5201/event/${id}/weather`;

    fetch(eventUrl)
        .then((response) => {
            if (!response.ok) {
                throw new Error(`Error fetching event data: ${response.statusText}`);
            }
            return response.json();
        })
        .then((weatherData) => {
            console.log(weatherData);
            weatherModalTitle.innerText = "Weather in " + weatherData.location.name;
            let html = `<div class="weather" id="weatherInTheModal">
                            <img class= "weatherIcon" src= ${weatherData.current.condition.icon} alt = "${weatherData.current.condition.text} icon" />
                            <p><b>${weatherData.current.condition.text}</b></p>
                        </div>
                        <div class="conditionsWeather">
                            <p> <b class="titleOfCondition"> Temperature :</b> ${weatherData.current.temp_c}°C</p>
                            <p> <b class="titleOfCondition"> Feels Like :</b> ${weatherData.current.feelslike_c}°C</p>
                            <p> <b class="titleOfCondition"> Visibility :</b> ${weatherData.current.vis_km} km</p>
                            <p> <b class="titleOfCondition"> Humidity :</b> ${weatherData.current.humidity}%</p>
                            <p> <b class="titleOfCondition"> Precipitations :</b> ${weatherData.current.precip_mm} mm</p>
                            <p> <b class="titleOfCondition"> UV Index :</b> ${weatherData.current.uv}</p>
                            <p> <b class="titleOfCondition"> Wind Speed :</b> ${weatherData.current.wind_kph} km/h</p>
                        </div>
                        `;
            modalWeatherContent.innerHTML = html;
        })
        .catch((error) => {
            console.error(error);
        });
    weatherModal.style.display = "block";
}


function closeWeatherModal() {
    const modal = document.getElementById("weatherModal");
    modal.style.display = "none";
}


window.onclick = function (event) {
    const modal = document.getElementById("eventModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }

    const modal2 = document.getElementById('addEventModal');
    if (event.target == modal2) {
        modal2.style.display = "none";
    }

    const modal3 = document.getElementById('weatherModal');
    if (event.target == modal3) {
        modal3.style.display = "none";
    }
}
