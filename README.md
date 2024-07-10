# Flutter Setup & Run

Clone the repo from https://github.com/xuala69/Smart-Attend.git

Ensure that you are using Flutter version 3.19.6 or higher.

No specific setup required for flutter other than the normal setup for a flutter project.

# Websocket setup and run

Once the repo is clones, cd to socketio-server folder and run node index.js

Ensure that you have node installed. You can follow the steps at https://nodejs.org/en/learn/getting-started/how-to-install-nodejs


# Communication between Flutter and Socket

Once you run the socket server, check the local ip address of the device you are running (PC/Mac etc where you are running the web socket) and update the ip address at flutter at lib/providers/socket_provider.dart
line 8 (Replace http://192.168.1.38 with the ip address of you local machine). Once replaced, run the flutter app on you device and the connection will be established and communication will be enabled.
