class PlacesController < ApplicationController
  def index
  end

  def show

    places = Rails.cache.read session[:last_search]

    places.each do |p|
        if p.id == params[:id]
          @place = p
        end
    end

  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:last_search] = params[:city]
      render :index
    end
  end
end