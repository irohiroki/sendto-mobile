class LinksController < ApplicationController
  before_filter :authenticate_user!

  def send_
    @link = current_user.link || current_user.build_link
    @link.update_attributes(:uri => params[:link], :title => params[:title])
  end

  def receive_
    if l = current_user.link && current_user.link.uri
      redirect_to l
    else
      render
    end
  end
end
