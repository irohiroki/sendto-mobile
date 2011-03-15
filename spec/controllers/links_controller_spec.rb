require 'spec_helper'

describe LinksController do
  before(:all) { create_user }

  let(:l){ mock_model(Link).as_null_object }
  let(:u){ User.first }

  after(:all) { User.delete_all }

  before do
    @controller.stub(:current_user).and_return(u)
    sign_in u
  end

  describe "GET send" do
    def do_send
      get 'send_', 'link' => 'http://example.com', 'title' => 'example'
    end

    shared_examples_for "updating and success" do
      it 'updates the link' do
        l.should_receive(:update_attributes).with(:uri => 'http://example.com', :title => 'example')
        do_send
      end

      specify do
        do_send
        response.should be_success
      end
    end

    context "if user has already a link" do
      before { u.should_receive(:link).and_return(l) }

      it_behaves_like "updating and success"
    end

    context "if user has no link yet" do
      before do
        u.stub(:link).and_return(nil)
        u.should_receive(:build_link).and_return(l)
      end

      it_behaves_like "updating and success"
    end
  end

  describe "GET receive" do
    context "if user has already a link" do
      before do
        u.stub(:link).and_return(l)
        l.stub(:uri).and_return('http://foo.com')
      end

      it "redirects to the saved link" do
        get 'receive_'
        response.should redirect_to('http://foo.com')
      end
    end

    context "if user has no link yet" do
      before { u.stub(:link).and_return(nil) }

      it "renders the default template" do
        get 'receive_'
        response.should render_template('links/receive_')
      end
    end
  end
end
