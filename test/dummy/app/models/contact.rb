class Contact < ActiveRecord::Base
  
  attr_accessor :hidden_field
  
  belongs_to :group
  
  validates_presence_of :name
  validates_presence_of :details
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :url
  validates_presence_of :group
  
  validates_format_of :email, :with => /\A([^\s]+)@([^\s]+)\Z/i, :message => "is not valid"
  validates_format_of :phone, :with => /\A[0-9\s\(\)\+\-]+\Z/i, :message => "is not valid"
  
  has_attached :avatar
  
end
