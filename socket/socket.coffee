io = require('socket.io').listen 3000
io.set 'log level', 1

io.sockets.on 'connection', (socket) ->
    socket.on 'post', (data) ->
        console.log data
        io.sockets.emit 'post', data

