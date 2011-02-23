require 'spec_helper'

describe Link do
  context "setting a link with invalid characters" do
    before { subject.update_attribute :uri, "http://a%A1-._~:/?#[]@!$&'()*+,;= \"^|`{}<>`\n\t\\" }

    it "sanitizes that" do
      subject.uri.should eq("http://a%A1-._~:/?#[]@!$&'()*+,;=%20%22%5E%7C%60%7B%7D%3C%3E%60%0A%09%5C")
    end
  end
end
