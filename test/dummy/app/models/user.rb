class User < ActiveRecord::Base

  module Formats
    EMAIL = /\A([^\s]+)@([^\s]+)\Z/i
  end

  has_secure_password

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :password

  validates_length_of :password, :in => 4..64, :unless => "password.blank?"

  validates_format_of :email, :with => Formats::EMAIL, :message => "should look like an email", :unless => "email.blank?"

  validates_uniqueness_of :email

end
