# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->

  whiteboard = $('.whiteboard.admin')

  if whiteboard.is(':visible')
    context = whiteboard[0].getContext('2d')

    clickX = []
    clickY = []
    clickDrag = []
    drawing = false

    addClick = (x, y, dragging) ->
      clickX.push x
      clickY.push y
      clickDrag.push dragging

    redraw = ->
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

    whiteboard.mousedown (e) ->
      mouseX = e.pageX - @offsetLeft
      mouseY = e.pageY - @offsetTop
      drawing = true
      addClick mouseX, mouseY, false
      App.broadcast.send_message x: mouseX, y: mouseY, dragging: false
      redraw()

    whiteboard.mousemove (e) ->
      if drawing
        mouseX = e.pageX - @offsetLeft
        mouseY = e.pageY - @offsetTop

        drawing = true
        addClick mouseX, mouseY, true
        App.broadcast.send_message x: mouseX, y: mouseY, dragging: true
        redraw()

    whiteboard.mouseup ->
      drawing = false

    whiteboard.mouseleave ->
      drawing = false


