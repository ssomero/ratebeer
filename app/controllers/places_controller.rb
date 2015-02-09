class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = "24c23e69ff2fbb68054b7562e5fc6576"
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    # or alternatively (if beermapping works slowly)
    # url = 'http://stark-oasis-9187.herokuapp.com/api/'

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(params[:city])}"
    places_from_api = response.parsed_response["bmp_locations"]["location"]

    if places_from_api.is_a?(Hash) and places_from_api['id'].nil?
      redirect_to places_path, :notice => "No places found in #{params[:city]}"
    else
      places_from_api = [places_from_api] if places_from_api.is_a?(Hash)
      @places = places_from_api.inject([]) do | set, location|
        set << Place.new(location)
      end
      render :index
    end



  end
end