$ = require 'jquery'
doT = require 'dot'
{ws} = require './ws'

name = 'anonymous'

# dom init
$input = $('#input')
$list = $('#list')

# focus
$input.focus()

# monitor
monitor = (event) ->
    if event? and event.keyCode is 13
        ws.emit 'post', {
            name: name,
            text: $input.val(),
            stamp: +new Date
        }
        $input.val('')

$input.on 'keyup', monitor

# dom update
itemFn = doT.template require('./template/item')
update = (data) ->
    $list.append itemFn(data)

# ws
ws.on 'post', update

