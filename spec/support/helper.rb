module AppSpecHelper
  def create_user
    User.create!(:email => 'e@m.com', :password => 'pass123', :password_confirmation => 'pass123')
  end
end
