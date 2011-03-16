require "spec_helper"

describe LinksController do
  describe "routing" do
    it "recognizes and generates #clear" do
      { :get => "/clear" }.should route_to(:controller => "links", :action => "clear")
    end
  end
end
