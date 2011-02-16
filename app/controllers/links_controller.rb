class LinksController < ApplicationController
  before_filter :authenticate_user!

  def send_
    current_user.update_attributes(params.slice('link', 'title'))
  end

  def receive_
    if l = current_user.escaped_link
      redirect_to l
    else
      render
    end
  end
end
