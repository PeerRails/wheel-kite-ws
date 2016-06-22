require "http"
class HomeController < ApplicationController
  def index
    render json: {text: "OK", message: "Kaiji"}.to_json
  end

  def search
    res = HTTP.post("#{mhost}/search",
          :json => { location: {long: location_params[:long], lat: location_params[:lat]} }).parse
    render json: res
  end

  def routing
    render json: {error: "Not Found"}, status: 404
  end

  def location_params
    params.require(:location).permit(:long, :lat)
  end

end
