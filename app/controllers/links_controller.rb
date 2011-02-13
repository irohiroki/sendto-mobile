class LinksController < ApplicationController
  def send_
    current_user.update_attributes(params.slice('link', 'title'))
  end

  def receive_
    redirect_to current_user.link
  end
end