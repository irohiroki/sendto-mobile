require 'spec_helper'

describe LinksController do
  let(:u){ create_user }

  before do
    @controller.stub(:current_user).and_return(u)
    sign_in u
  end

  describe "GET send" do
    it "should be successful" do
      get 'send_', 'link' => 'http://example.com', 'title' => 'example'
      response.should be_success
    end

    it 'saves the link and the title' do
      u.should_receive(:update_attributes).with('link' => 'http://example.com', 'title' => 'example')
      get 'send_', 'link' => 'http://example.com', 'title' => 'example'
    end
  end

  describe "GET receive" do
    before { u.update_attribute :link, 'http://foo.com' }

    it "redirects to the saved link" do
      get 'receive_'
      response.should redirect_to('http://foo.com')
    end
  end
end
