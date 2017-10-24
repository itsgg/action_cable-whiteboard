App.broadcast = App.cable.subscriptions.create "BroadcastChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    console.log 'Broadcaster connected'

  disconnected: ->
    # Called when the subscription has been terminated by the server
    console.log 'Broadcaster disconnected'

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log 'Broadcaster received'
    console.log data
    addClick data.message.x, data.message.y, data.message.dragging
    redraw()

  send_message: (message) ->
    @perform 'send_message', { message: message }

clickX = []
clickY = []
clickDrag = []
drawing = false

addClick = (x, y, dragging) ->
  return unless $('.whiteboard.student').is(':visible')
  clickX.push x
  clickY.push y
  clickDrag.push dragging

redraw = ->
  return unless $('.whiteboard.student').is(':visible')
  context = $('.whiteboard.student')[0].getContext('2d')
  context.clearRect 0, 0, context.canvas.width, context.canvas.height
  context.strokeStyle = '#df4b26'
  context.lineJoin = 'round'
  context.lineWidth = 1
  for i in [0..clickX.length]
    context.beginPath()
    if clickDrag[i] && i
      context.moveTo clickX[i - 1], clickY[i - 1]
    else
      context.moveTo clickX[i] - 1, clickY[i]
    context.lineTo clickX[i], clickY[i]
    context.closePath()
    context.stroke()
