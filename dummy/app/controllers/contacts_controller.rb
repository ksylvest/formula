class ContactsController < ApplicationController
  
  respond_to :html
  
  # GET /contacts
  def index
    @contacts = Contact.all
    respond_with(@contacts)
  end
  
  # GET /contacts/new
  def new
    @contact = Contact.new
    respond_with(@contact)
  end
  
  # POST /contacts
  def create
    @contact = Contact.create(params[:contact])
    respond_with(@contact, :location => contacts_path)
  end
  
end
