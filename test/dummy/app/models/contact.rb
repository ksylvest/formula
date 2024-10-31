# frozen_string_literal: true

class Contact < ActiveRecord::Base
  attr_accessor :secret

  belongs_to :group

  validates :name, presence: true
  validates :details, presence: true
  validates :url, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :email, format: { with: /\A([^\s]+)@([^\s]+)\Z/i, message: 'is not valid' }
  validates :phone, format: { with: /\A[0-9\s\(\)\+\-]+\Z/i, message: 'is not valid' }

  has_one_attached :avatar
end
