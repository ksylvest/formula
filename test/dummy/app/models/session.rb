class Session

  module Formats
    EMAIL = /\A([^\s]+)@([^\s]+)\Z/i
  end

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email
  attr_accessor :password

  validates_presence_of :email
  validates_presence_of :password

  validates_format_of :email, :with => Formats::EMAIL, :message => "should look like an email", :unless => "email.blank?"

  validate do
    return unless errors.empty?

    errors[:email]    << "is not valid" and return unless self.user
    errors[:password] << "is not valid" and return unless self.user.authenticate(self.password)
  end

  def initialize(attributes = {})
    @email    = attributes[:email]
    @password = attributes[:password]
  end

  def user
    @user ||= User.find_by_email(self.email)
  end

  def persisted?
    user and user.authenticate(self.password)
  end

end
