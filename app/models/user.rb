class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_reader :link

  attr_accessible :email, :password, :password_confirmation, :remember_me, :link, :title

  validates :escaped_link, :format => {:with => /^(?:ftp|https?)/, :allow_nil => true}

  def clear_link
    @link = nil
    self.update_attribute :escaped_link, nil
  end

  def link=(l)
    @link = l.tap do
      self.escaped_link = %r{^(?:ftp|https?)://} === l ? escape(l) : ''
    end
  end

  def escape(s)
    s.gsub(%r{[^-\w.~:/?#\[\]@!$&'()*+,;=%]}){|c| "%%%02X" % c.ord }
  end
end
