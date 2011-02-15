require 'spec_helper'

describe "Links" do
  before { create_user }

  def sign_in
    fill_in "Email", :with => 'e@m.com'
    fill_in "Password", :with => 'pass123'
    click_button "Sign in"
  end

  describe "send" do
    it 'saves a given link' do
      visit send_path, :get, 'link' => 'http://irohiroki.com'
      sign_in
      response.should contain("Successfully sent")
    end

    it "doesn't save unsupported uri" do
      visit send_path, :get, 'link' => 'mailto:e@m.com'
      sign_in
      response.should contain("Sorry, unsupported link")
    end
  end
end
