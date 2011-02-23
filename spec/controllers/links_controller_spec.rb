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

    context "if user has already a link" do
      before do
        u.create_link(:uri => 'http://a', :title => 'a')
        get 'send_', 'link' => 'http://example.com', 'title' => 'example'
      end

      it 'updates the link' do
        u.link.uri.should eq 'http://example.com'
      end

      it 'updates the title' do
        u.link.title.should eq 'example'
      end
    end

    context "if user has no link yet" do
      pending
    end
  end

  describe "GET receive" do
    before { u.create_link :uri => 'http://foo.com' }

    it "redirects to the saved link" do
      get 'receive_'
      response.should redirect_to('http://foo.com')
    end

    context "after an unsuccessful send" do
      pending
    end
  end
end
