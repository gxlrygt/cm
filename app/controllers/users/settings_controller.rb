class Users::SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_user

  respond_to :html

  def edit
    respond_with(@user)
  end

  def update
    flash[:notice] = 'User profile successfully updated.' if @user.update_attributes(user_params)
    respond_with(@user, location: { action: :edit })
  end

  private
    
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, external_site_passwords_attributes: [:id, :username, :password])
  end
end