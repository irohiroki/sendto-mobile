class Link < ActiveRecord::Base
  belongs_to :user

  validates :uri, :format => {:with => /^(?:ftp|https?)/}

  before_save :sanitize_uri

  def sanitize_uri
    uri.gsub!(%r{[^-\w.~:/?#\[\]@!$&'()*+,;=%]}){|c| "%%%02X" % c.ord }
  end
end
