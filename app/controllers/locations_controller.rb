class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
    
    if @location.save
      flash[:notice] = "Your location has been created!"
      redirect_to home_path
    end
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
