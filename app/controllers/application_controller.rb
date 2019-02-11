class ApplicationController < ActionController::Base
  before_action { request.format = :json }

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: {
      error: error.record.errors
    }, status: :unprocessable_entity
  end
  rescue_from User::RoleRequired do |error|
    render json: {
      error: {
        message: error.message,
        required: error.required,
        actual: error.actual
      }
    }, status: :forbidden
  end

  private

  def require_role!(name)
    unless current_user.role == name.to_s
      raise User::RoleRequired.new(required: name, actual: current_user.role)
    end
  end
end
