const apiUrl = 'http://localhost:4566/restapis/YOUR_REST_API_ID/local/_user_request_';

function createItem() {
    fetch(`${apiUrl}/create`, {
        method: 'POST',
        body: JSON.stringify({ ID: '1', info: 'sample info' }),
        headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(data => console.log(data));
}

function readItem() {
    fetch(`${apiUrl}/read?id=1`)
    .then(response => response.json())
    .then(data => console.log(data));
}

function updateItem() {
    fetch(`${apiUrl}/update`, {
        method: 'PUT',
        body: JSON.stringify({ ID: '1', info: 'updated info' }),
        headers: { 'Content-Type': 'application/json' }
    })
    .then(response => response.json())
    .then(data => console.log(data));
}

function deleteItem() {
    fetch(`${apiUrl}/delete?id=1`, {
        method: 'DELETE'
    })
    .then(response => response.json())
    .then(data => console.log(data));
}