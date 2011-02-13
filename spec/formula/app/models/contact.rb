class Contact < ActiveRecord::Base
  
  belongs_to :group
  
  validates_presence_of :name
  validates_presence_of :details
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :url
  
end
