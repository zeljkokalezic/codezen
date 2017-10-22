class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "test#{params[:test_id]}#{current_user.id}"
    #ActionCable.server.broadcast "test#{params[:test_id]}#{current_user.id}", message: "Connected"
  end
end