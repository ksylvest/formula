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

  # GET /contacts/:id/edit
  def edit
    @contact = Contact.find(params[:id])
    respond_with(@contact)
  end

  # POST /contacts
  def create
    @contact = Contact.create(attributes)
    respond_with(@contact, :location => contacts_path)
  end

  # PUT /contacts
  def update
    @contact = Contact.find(params[:id])
    @contact.attributes = attributes
    @contact.save
    respond_with(@contact, :location => contacts_path)
  end

  # DELETE /contacts/:id
  def destroy
    @contact = Contact.find(params[:id])
    @contact.delete
    respond_with(@contact, :location => contacts_path)
  end

private

  def attributes
    params.require(:contact).permit(:name, :details, :email, :phone, :url, :avatar, :secret, :group_id)
  end

end
