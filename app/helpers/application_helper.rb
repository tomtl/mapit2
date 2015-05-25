module ApplicationHelper

  def index_map_link
    markers_array = []

    @locations.each do |location|
      markers_array << "&markers=#{location.latitude},#{location.longitude}"
    end

    markers_string = markers_array.join
    "http://maps.google.com/maps/api/staticmap?size=600x400&sensor=false#{markers_string}"
  end
end
