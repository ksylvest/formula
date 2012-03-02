class Group < ActiveRecord::Base

  has_many :contacts

  validates_presence_of :name

end
