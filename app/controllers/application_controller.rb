class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |e|
    render json: {error: "Not Valid Parameters"}, status: 400
  end

  def mhost
    ENV["WHEELKITE_HOST"] ||= "http://localhost:9000"
  end
end
