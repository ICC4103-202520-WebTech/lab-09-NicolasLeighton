class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Handle authorization errors from CanCanCan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "🚫 You are not authorized to perform this action."
  end
end
