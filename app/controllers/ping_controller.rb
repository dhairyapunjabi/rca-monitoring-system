class PingController < ApplicationController
  def health_check
    render 'json': 'pong', status: :ok
  end
end
