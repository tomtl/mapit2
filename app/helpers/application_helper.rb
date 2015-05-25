module ApplicationHelper

  def index_map_link
    markers_array = []

    @locations.each do |location|
      markers_array << "&markers=#{location.latitude},#{location.longitude}"
    end

    markers_string = markers_array.join
    "http://maps.google.com/maps/api/staticmap?size=640x640#{markers_string}"
  end

  def single_location_map_link
    "http://maps.google.com/maps/api/staticmap?size=640x480&sensor=false&zoom=16&markers=#{@location.address}"
  end
end
