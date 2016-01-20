class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  include DateHelper
  include NumberHelper

  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
    
  end

  before_action :authenticate_user!#, only: [:show, :edit, :update, :destroy]  

  before_filter :configure_permitted_parameters, if: :devise_controller?


	protected

	def configure_permitted_parameters
	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
    :email, :name, :password, :password_confirmation,
    :firstname, :lastname,:middlename, :name_chinese,
    :phone_mobile,:phone_home,:phone_work,
    :pic1,:pic2,:pic3,
    :contact1_name, :contact1_phone, :contact1_relationship,
    :contact2_name, :contact2_phone, :contact2_relationship,
    :address_street,:address_city,:address_state,:address_zipcode
    ) }

	devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
    :email, :name, :password, :password_confirmation, :current_password,
    :firstname, :lastname,:middlename,
    :phone_mobile,:phone_home,:phone_work,
    :pic1,:pic2,:pic3,
    :contact1_name, :contact1_phone, :contact1_relationship,
    :contact2_name, :contact2_phone, :contact2_relationship,
    :address_street,:address_city,:address_state,:address_zipcode
    ) }
	end


end
