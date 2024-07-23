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
            "</tr>";

        for (let i = 0; i < data.length; i++) {
            let participantsCount = await getParticipants(data[i].id);
            str +=
                `<tr onclick="openModal(${data[i].id})">
                    <td>${data[i].id}</td>
                    <td>${data[i].name}</td>
                    <td>${data[i].startDate}</td>
                    <td>${data[i].endDate}</td>
                    <td>${participantsCount}</td>
                    <td>${data[i].maxRegistrations}</td>
                    <td>${data[i].location}</td>
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
                tableHTML +=
                    `<tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.dateOfBirth}</td>
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

window.onclick = function (event) {
    const modal = document.getElementById("eventModal");
    if (event.target == modal) {
        modal.style.display = "none";
    }

    const modal2 = document.getElementById('addEventModal');
    if (event.target == modal2) {
        modal2.style.display = "none";
    }
}






