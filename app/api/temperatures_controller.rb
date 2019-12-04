module Api
  class TemperaturesController < ActionController::Base
    protect_from_forgery
    skip_before_action :verify_authenticity_token, if: :json_request?

    def index
      temperatures = Temperature.all
      if temperatures.any?
        render json: temperatures
      else
        render json: {}, status: :not_found
      end
    end

    def show
      temperature = Temperature.find(params[:id]) rescue nil
      if temperature
        render json: temperature
      else
        render json: {}, status: :not_found
      end
    end

    def create
      temperature = Temperature.new(temperature_params)
      if temperature.save
        render json: temperature, location: api_temperature_path(temperature.id), status: :created
      else
        render json: { errors: temperature.errors }, status: :unprocessable_entity
      end
    end

    ...
    ...

    protected

    def json_request?
      request.format.json?
    end


    private

    def temperature_params
      params.require(:temperature).permit(:value)
    end
  end
end