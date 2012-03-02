class SessionsController < ApplicationController

  respond_to :html, :js

  before_filter :authenticate!, :only => [:destroy]
  before_filter :deauthenticate!, :only => [:new, :create]

  # GET /session/new
  def new
    @session = Session.new

    respond_with(@session)
  end

  # POST /session
  def create
    @session = Session.new(params[:session])

    flash[:notice] = 'Session create successful.' if @session.valid?
    flash[:error] = 'Session create failed.' if @session.invalid?

    authenticate(@session.user) if @session.valid?
    respond_with(@session, :location => restore(:default => root_path))
  end

  # DELETE /session
  def destroy
    flash[:notice] = 'Session destroyed.'

    deauthenticate()

    respond_to do |format|
      format.html { redirect_to(restore(:default => root_path)) }
    end
  end

end
