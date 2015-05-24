class LocationsController < ApplicationController
  before_action :require_user

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user

    if @location.save
      flash[:notice] = "Your location has been created!"
      redirect_to home_path
    else
      flash[:error] = "Please fix the following errors."
      render :index
    end
  end

  def index
    @location = Location.new
    @locations = current_user.locations

    markers_array = []

    @locations.each do |location|
      marker = "&markers=label:#{location.id}%7C#{location.latitude},#{location.longitude}"
      markers_array << marker
    end

    @markers = markers_array.join
  end

  def show
    @location = Location.find(params[:id])
  end

  def edit
    @location = Location.find(params[:id])
    require_location_creator(@location)
  end

  def update
    @location = Location.find(params[:id])
    @location.address = location_params[:address]

    if (@location.user == current_user) && @location.save
      flash[:success] = "The address has been updated successfully!"
      redirect_to location_path(@location)
    elsif @location.user == current_user
      flash[:error] = "Please fix the following errors."
      render :edit
    else
      flash[:error] = "You do not have permission to do that."
      redirect_to home_path
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if (@location.user == current_user) && @location.destroy
      flash[:notice] = "Address has been deleted successfully"
      redirect_to home_path
    elsif @location.user != current_user
      flash[:error] = "You do not have permission to do that."
      redirect_to home_path
    end
  end

  private
    def location_params
      params.require(:location).permit(:address)
    end

    def require_location_creator(location)
      if location.user != current_user
        flash[:error] = "You do not have permission to do that."
        redirect_to home_path
      end
    end
end
