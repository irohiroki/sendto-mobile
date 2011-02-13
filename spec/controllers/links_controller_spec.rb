require 'spec_helper'

describe LinksController do
  before { @controller.stub(:current_user).and_return(u) }

  describe "GET send" do
    let(:u){ mock_model(User).as_null_object }

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
    let(:u){ mock_model(User, :link => 'http://foo.com').as_null_object }

    it "redirects to the saved link" do
      get 'receive_'
      response.should redirect_to('http://foo.com')
    end
  end
end
