# frozen_string_literal: true

module ErrorsRescuer
  extend ActiveSupport::Concern

  included do
    unless Rails.application.config.consider_all_requests_local
      rescue_from ActionController::RoutingError, with: -> { rescue_404 }
      rescue_from ActionController::UnknownFormat, with: -> { rescue_404 }
    end

    rescue_from(ActiveRecord::RecordNotFound) { |error| rescue_404(error) }
    rescue_from(ActionController::ParameterMissing) { |error| rescue_400(error) }

    def rescue_404(error = nil)
      message = error && error.message.split(" [")[0] # remove sql query details

      render json: { errors: { message: message } }, status: :not_found
    end

    def rescue_400(error = nil)
      message = error && error.message.split("Did you mean?")[0].strip

      render json: { errors: { message: message } }, status: :bad_request
    end
  end
end
