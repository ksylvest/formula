# frozen_string_literal: true

class User < ApplicationRecord
  module Formats
    EMAIL = /\A([^\s]+)@([^\s]+)\Z/i.freeze
  end

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: Formats::EMAIL, message: 'should look like an email' }, unless: -> { email.blank? }
  validates :email, uniqueness: true, unless: -> { email.blank? }
  validates :password, { presence: true }
  validates :password, length: { in: 4..64 }, unless: -> { password.blank? }
end
