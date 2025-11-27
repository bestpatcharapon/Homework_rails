class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.

  allow_browser versions: :modern
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    recipes_path
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to recipes_path, alert: "คุณไม่มีสิทธิ์เข้าถึงหน้านี้"
  end
end
