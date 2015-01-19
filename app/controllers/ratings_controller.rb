class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
  @ratings = Rating.new
  end

  def create
    #redirect!
  end
end