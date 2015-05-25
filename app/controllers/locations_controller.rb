class LocationsController < ApplicationController
  before_action :require_user
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :require_location_creator, only: [:edit, :update, :destroy]

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
  end

  def show
  end

  def edit
  end

  def update
    @location.address = location_params[:address]

    if @location.save
      flash[:success] = "The address has been updated successfully!"
      redirect_to location_path(@location)
    else
      flash[:error] = "Please fix the following errors."
      render :edit
    end
  end

  def destroy
    if @location.destroy
      flash[:notice] = "Address has been deleted successfully"
      redirect_to home_path
    end
  end

  private
    def location_params
      params.require(:location).permit(:address)
    end

    def set_location
      @location = Location.find(params[:id])
    end

    def require_location_creator
      unless current_user == @location.user
        flash[:error] = "You are not allowed to do that."
        redirect_to home_path
      end
    end
end
