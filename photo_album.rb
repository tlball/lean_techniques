# frozen_string_literal: true

require 'json'
require 'net/http'

class PhotoAlbum
  ENDPOINT = 'https://jsonplaceholder.typicode.com/photos'

  def request_photos(album_id = nil)
    res = Net::HTTP.get_response(uri(album_id))
    if res.is_a?(Net::HTTPSuccess)
      return parse_body(res.body).map { |photo| "[#{photo['id']}] #{photo['title']}" }
    end
    "Request failed with #{res.code} #{res.message}"
  end

  def uri(album_id = nil)
    uri = URI(ENDPOINT)
    if album_id
      params = { albumId: album_id }
      uri.query = URI.encode_www_form(params)
    end
    uri
  end

  private

  def parse_body(body)
    JSON.parse(body)
  end
end
