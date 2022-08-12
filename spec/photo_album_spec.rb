require 'spec_helper'

describe PhotoAlbum do

  let(:photo_album) { PhotoAlbum.new }
  describe 'uri' do
    it 'returns the default uri when no album_id given' do
      expect(photo_album.uri.to_s).to eq(PhotoAlbum::ENDPOINT)
    end

    it 'returns the uri with a proper query string using the given album_id' do
      expect(photo_album.uri(3).to_s).to eq("#{PhotoAlbum::ENDPOINT}?albumId=3")
      expect(photo_album.uri('foo').to_s).to eq("#{PhotoAlbum::ENDPOINT}?albumId=foo")
    end
  end
end
