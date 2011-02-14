class LinksController < ApplicationController
  before_filter :authenticate_user!

  def send_
    current_user.update_attributes(params.slice('link', 'title'))
  end

  def receive_
    redirect_to current_user.escaped_link
  end
end
