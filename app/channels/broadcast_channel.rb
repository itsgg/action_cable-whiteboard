class BroadcastChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'broadcast_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    ActionCable.server.broadcast 'broadcast_channel', data
  end
end
