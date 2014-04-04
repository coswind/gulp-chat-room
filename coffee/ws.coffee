io = require 'socket.io-client'

ws = exports.ws = io.connect 'http://localhost:3000'
