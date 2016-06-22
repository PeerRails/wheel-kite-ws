class HomeController < ApplicationController
  def index
    render json: {text: "OK", message: "Kaiji"}.to_json
  end

  def search

  end

end
