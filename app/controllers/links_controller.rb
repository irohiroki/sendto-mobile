class LinksController < ApplicationController
  before_filter :authenticate_user!

  def clear
    l = current_user.link and l.destroy
    redirect_to r_path, :notice => "Cleard. You can bookmark this page."
  end

  def send_
    @link = current_user.link || current_user.build_link
    @link.update_attributes(:uri => params[:link], :title => params[:title])
    Log.create :uri => @link.uri if @link.valid?
  end

  def receive_
    if l = current_user.link && current_user.link.uri
      redirect_to l
    else
      render
    end
  end
end
