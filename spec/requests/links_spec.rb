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

  describe "receive" do
    context 'without any link to receive' do
      before { User.first.clear_link }

      it 'shows the default page' do
        visit receive_path
        sign_in
        response.should contain("You have no link to receive")
      end
    end
  end
end
