# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up

  respond_to :json
  def new
   @user = User.new
   @user.images.build
   # super
  end
  
  def create
    @user = User.new(sign_up_params)
    byebug
    if @user.save
      render :json=> @user.as_json(:auth_token=>@user.auth_token, :email=>@user.email), :status=>201
    end
  end
  # POST /resource
  #def create
   # super
  # end

  # GET /resource/edit
  #def edit
    # super
  #end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
  # If you have extra params to permit, append them to the sanitizer.
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :city, images_attributes: [:id, :name])
  end
  # The path used after sign up.
   #def after_sign_up_path_for(resource)
    # super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
end
