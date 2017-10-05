class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!

# before_action :configure_permitted_parameters, if: :devise_controller?
#   protected
#     def configure_permitted_parameters
#        devise_parameter_sanitizer.for(:sign_up) {|u|
#         u.permit(:first_name, :email, :password,
#                                    :password_confirmation,:picture,:last_name,:phone_number,:dob)}
#     end
end
