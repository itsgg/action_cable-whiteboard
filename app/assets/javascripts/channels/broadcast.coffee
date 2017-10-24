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

  send_message: (message) ->
    console.log 'Broadcaster send_message'
    @perform 'send_message', { message: message }
