# frozen_string_literal: true

require 'json'
require 'net/http'

class PhotoAlbum
  ENDPOINT = 'https://jsonplaceholder.typicode.com/photos'

  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  def request_photos
    res = Net::HTTP.get_response(uri)
    raise "Request failed with #{res.code} #{res.message}" unless res.is_a?(Net::HTTPSuccess)

    parse_body(res.body).map { |photo_data| Photo.new(photo_data) }
  end

  def uri
    uri = URI(ENDPOINT)
    if id
      params = { albumId: id }
      uri.query = URI.encode_www_form(params)
    end
    uri
  end

  def print_photos
    photo_list = request_photos.map(&:to_s)
    return "No photos found for Album ID '#{id}'" if photo_list.empty?

    photo_list
  end

  private

  def parse_body(body)
    JSON.parse(body)
  end
end
