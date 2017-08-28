const express = require('express');
const app = express();
const ws = require('express-ws')(app);

const PORT = 8080;
const CLIENTS = [];

app.listen(PORT, (() => {
	console.log(`Listening on port ${PORT}`);
}));

app.ws('/connect', (websocket, request) => {
	console.log('Client connected');
	CLIENTS.push(websocket);
	websocket.on('message', (message) => {
		for(const prop of CLIENTS) {
			if (prop.readyState === 1) {
				prop.send(message);
			}
		}
	});
});