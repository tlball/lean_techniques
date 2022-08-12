# frozen_string_literal: true

class Photo
  attr_accessor :id, :title, :url, :thumbnail_url

  def initialize(args)
    @id = args['id']
    @title = args['title']
    @url = args['url']
    @thumbnail_url = args['thumbnailUrl'] || args['thumbnail_url']
  end

  def to_s
    "[#{id}] #{title}"
  end
end
