# frozen_string_literal: true

require 'json'

class PhotoAlbum
  ENDPOINT = 'https://jsonplaceholder.typicode.com/photos'

  def uri(album_id = nil)
    uri = URI(ENDPOINT)
    if album_id
      params = { albumId: album_id }
      uri.query = URI.encode_www_form(params)
    end
    uri
  end
end
