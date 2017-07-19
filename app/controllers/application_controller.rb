class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include CanCan::ControllerAdditions

  before_action :log_headers
  before_action :authenticate_user!, unless: :allow_unauthenticated

  def allow_unauthenticated
    if(
        (action_name == "letsencrypt" && controller_name == "pages") ||
        (controller_name == "sessions" and action_name == "create") ||
        (controller_name == "registrations" and action_name == "create")
      )
      true
    else
      false
    end
  end

  rescue_from Exception do |exception|
    logger.error "Uncaught Exception: #{exception}"
    logger.error exception.backtrace.join("\n")
    session[:exception] = exception

    render json: {exception_class: exception.class.name, exception: exception.to_s}, status: :internal_server_error
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: {exception: exception.to_s}, status: :unprocessable_entity
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: {}, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {}, status: :not_found
  end

  def log_headers
    logger.debug("Token #{request.headers['Access-Token']} from client #{request.headers['client']}")
  end
end
