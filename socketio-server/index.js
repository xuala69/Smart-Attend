const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

io.on('connection', (socket) => {
    console.log('A user connected');

    // Listen for a message from the client
    socket.on('attendance', (msg) => {
        console.log('Message received: ' + msg);

        // Send a response back to the client
        setTimeout(() => {
            const response = msg + ' returned successfully';
            socket.emit('attendanceResponse', response);
        }, 30000); // 30000 milliseconds = 30 seconds
        // const response = msg + ' returned successfully';
        // socket.emit('attendanceResponse', response);
    });

    socket.on('disconnect', () => {
        console.log('User disconnected');
    });
});

server.listen(3000, () => {
    console.log('Server is running on port 3000');
});
