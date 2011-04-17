require 'spec_helper'

describe "Links" do
  before(:all) { create_user }
  after(:all) { User.delete_all }

  def sign_in
    fill_in "Email", :with => 'e@m.com'
    fill_in "Password", :with => 'pass123'
    click_button "Sign in"
  end

  describe "send" do
    it 'saves a given link' do
      visit send_path, :get, 'link' => 'http://irohiroki.com'
      sign_in
      response.should contain("successfully")
    end

    it "doesn't save unsupported uri" do
      visit send_path, :get, 'link' => 'mailto:e@m.com'
      sign_in
      response.should contain("Sorry, unsupported link")
    end
  end

  describe "receive" do
    context 'without any link to receive' do
      it 'shows the default page' do
        visit r_path
        sign_in
        response.should contain("You have no link to receive")
      end
    end
  end

  describe "clear" do
    context "when he has a link" do
      before { User.first.create_link(:uri => 'http://irohiroki.com') }

      it "clears the link" do
        visit clear_path
        sign_in
        response.should contain("Cleard. You can bookmark this page.")
      end
    end
  end
end
