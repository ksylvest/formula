# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate!, only: %i[destroy]
  before_action :deauthenticate!, only: %i[new create]

  # GET /session/new
  def new
    @session = Session.new
  end

  # POST /session
  def create
    @session = Session.new(attributes)

    flash[:notice] = 'Session create successful.' if @session.valid?
    flash[:error] = 'Session create failed.' if @session.invalid?

    authenticate(@session.user) if @session.valid?

    if @session.valid?
      authenticate(@session.user)
      redirect_to(restore(default: root_path))
    else
      render :new, status: 422
    end
  end

  # DELETE /session
  def destroy
    flash[:notice] = 'Session destroyed.'

    deauthenticate

    redirect_to(restore(default: root_path))
  end

  private

  def attributes
    params.require(:session).permit(:email, :password)
  end
end
