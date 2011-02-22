require 'spec_helper'

describe User do
  let(:u){ create_user }

  before { User.delete_all }

  describe '#escaped_link' do
    it 'escapes links' do
      u.link = "http://a%A1-._~:/?#[]@!$&'()*+,;= \"^|`{}<>`\n\t\\"
      u.escaped_link.should eq("http://a%A1-._~:/?#[]@!$&'()*+,;=%20%22%5E%7C%60%7B%7D%3C%3E%60%0A%09%5C")
    end

    it 'accepts ftp' do
      u.link = 'ftp://a'
      u.escaped_link.should be_present
    end

    it 'accepts http' do
      u.link = 'http://a'
      u.escaped_link.should be_present
    end

    it 'accepts https' do
      u.link = 'https://a'
      u.escaped_link.should be_present
    end

    it 'rejects other schema' do
      u.link = 'git://github.com/irohiroki/foo.git'
      u.escaped_link.should be_blank
    end
  end
end
