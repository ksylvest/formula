# frozen_string_literal: true

class Session
  include ActiveModel::Model

  module Formats
    EMAIL = /\A([^\s]+)@([^\s]+)\Z/i.freeze
  end

  attr_accessor :email, :password

  validates_presence_of :email
  validates_presence_of :password

  validates :email, format: { with: Formats::EMAIL, message: 'should look like an email' }, unless: -> { email.blank? }

  validate do
    return unless errors.empty?

    errors[:email]    << 'is not valid' and return unless user
    errors[:password] << 'is not valid' and return unless user.authenticate(password)
  end

  def initialize(attributes = {})
    @email    = attributes[:email]
    @password = attributes[:password]
  end

  def user
    @user ||= User.find_by_email(email)
  end

  def persisted?
    user&.authenticate(password)
  end
end
