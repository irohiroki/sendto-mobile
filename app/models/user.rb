class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_reader :link

  attr_accessible :email, :password, :password_confirmation, :remember_me, :link, :title

  validates :escaped_link, :presence => true

  def link=(l)
    @link = l.tap do
      m = l.match(%r{^((?:ftp|https?)://)(.*)}m)
      self.escaped_link =
        if m
          scheme, path = m[1,2]
          scheme + CGI.escape(path)
        else
          nil
        end
    end
  end
end
