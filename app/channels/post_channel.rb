class PostChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "post"
  end

  def say_hi
    puts "\n HOLA FROM websocket \n"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
