$ = require 'jquery'
doT = require 'dot'
{ws} = require './ws'
dateformat = require 'dateformat'

name = 'anonymous'
new_time = ->
	now = new Date()
	dateformat now, 'h:MM:ss TT'

# dom init
$name = $('#name')
$list = $('#list')
$input = $('#input')

# init
$name.val name
$input.focus()

# monitor
monitor = (event) ->
    if event? and event.keyCode is 13
        ws.emit 'post', {
            name: name,
            text: $input.val(),
            stamp: new_time()
        }
        $input.val('')

$input.on 'keyup', monitor
$name.on 'blur', ->
    name = $name.val()

# dom update
itemFn = doT.template require('./template/item')
update = (data) ->
    $list.append itemFn(data)

# ws
ws.on 'post', update

