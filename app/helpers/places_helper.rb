module PlacesHelper
  def places_index_json(places)
    places.map do |place|
      {
        name: place.name,
        count: place.videos.count,
        show: place_path(place),
      }
    end.to_json
  end
end
