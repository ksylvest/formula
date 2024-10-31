# frozen_string_literal: true

class ContactsController < ApplicationController
  # GET /contacts
  def index
    @contacts = Contact.all
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/:id/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  def create
    @contact = Contact.new(attributes)

    if @contact.save
      redirect_to contacts_path
    else
      render :new, status: 422
    end
  end

  # PUT /contacts
  def update
    @contact = Contact.find(params[:id])
    @contact.attributes = attributes

    if @contact.save
      redirect_to contacts_path
    else
      render :edit, status: 422
    end
  end

  # DELETE /contacts/:id
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path
  end

  private

  def attributes
    params.require(:contact).permit(:name, :details, :email, :phone, :url, :avatar, :secret, :group_id)
  end
end
