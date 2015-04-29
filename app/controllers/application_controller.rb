class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def authenticate_for_admin_access!
      authenticate_user!
      unless current_user.role?(:administrator)
          flash[:alert] = 'Não autorizado!'
          redirect_to root_path
      end
  end

  def authenticate_active_admin!
    authenticate_user!
    unless current_user.role?(:administrator)
      flash[:alert] = 'Não autorizado!'
      redirect_to root_path
    end
  end

  def current_admin_user
      return nil if user_signed_in? && !current_user.admin?
      current_user
  end

  protected
  def layout_by_resource
    (request.xhr? and devise_controller?) ? 'devise' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :email, :gender, :city, :birthdate, :avatar]
  end

end
