class LocationsController < ApplicationController
  def new
    @location = Location.new
  end
  
  def create
    @location = Location.create(location_params)
  end
  
  def index
    @location = Location.new
    @locations = Location.all
  end
  
  private
    def location_params
      params.require(:location).permit(:address)
    end
end