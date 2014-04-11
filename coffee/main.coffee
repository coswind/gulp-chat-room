$ = require 'jquery'
doT = require 'dot'
{ws} = require './ws'
moment = require 'moment'
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
            time: +new Date,
            stamp: moment().fromNow()
        }
        $input.val('')

$input.on 'keyup', monitor
$name.on 'blur', ->
    name = $name.val()

# dom update
itemFn = doT.template require('./template/item')
update = (data) ->
    $list.append itemFn(data)
    document.getElementById('list-content').scrollTop = 999999999
    $('.extra').each (index, item) ->
        $(item).text moment($(item).data('time')).fromNow()

# ws
ws.on 'post', update

