class EpisodesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "episodes"
  end
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
  end
end
