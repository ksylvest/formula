# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :contacts

  validates_presence_of :name
end
