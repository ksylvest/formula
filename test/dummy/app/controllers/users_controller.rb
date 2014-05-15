class UsersController < ApplicationController

  respond_to :html, :js

  before_filter :authenticate!, :only => [:edit, :update]
  before_filter :deauthenticate!, :only => [:new, :create]

  # GET /user/new
  def new
    @user = User.new

    respond_with(@user)
  end

  # GET /user/edit
  def edit
    @user = user

    respond_with(@user)
  end

  # POST /user
  def create
    @user = User.create(attributes)

    flash[:notice] = 'User create successful.' if @user.valid?
    flash[:error] = 'User create failed.' if @user.invalid?

    authenticate(@user) if @user.valid?
    respond_with(@user, :location => restore(:default => root_path))
  end

  # PUT /user
  def update
    @user = user

    @user.attributes = attributes
    @user.save

    flash[:notice] = 'User update successful.' if @user.valid?
    flash[:error] = 'User update failed.' if @user.invalid?

    respond_with(@user, :location => restore(:default => root_path))
  end

private

  def attributes
    params.require(:user).permit(:name, :email, :password)
  end

end
