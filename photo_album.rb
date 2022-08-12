# frozen_string_literal: true

require 'json'
require 'net/http'

class PhotoAlbum
  ENDPOINT = 'https://jsonplaceholder.typicode.com/photos'

  def request_photos(album_id = nil)
    res = Net::HTTP.get_response(uri(album_id))
    raise "Request failed with #{res.code} #{res.message}" unless res.is_a?(Net::HTTPSuccess)

    parse_body(res.body).map { |photo_data| Photo.new(photo_data) }
  end

  def uri(album_id = nil)
    uri = URI(ENDPOINT)
    if album_id
      params = { albumId: album_id }
      uri.query = URI.encode_www_form(params)
    end
    uri
  end

  def print_photos(album_id = nil)
    request_photos(album_id).map(&:to_s)
  end

  private

  def parse_body(body)
    JSON.parse(body)
  end
end
