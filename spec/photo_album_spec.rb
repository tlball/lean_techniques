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

  describe 'request_photos' do
    let(:response) { Net::HTTPSuccess.new('1.1', 200, 'OK') }
    let(:parsed_body) { [] }

    before do
      allow(Net::HTTP).to receive(:get_response) { response }
      allow(response).to receive(:body) { JSON(parsed_body) }
    end

    it 'requests photos from the endpoint' do
      expect(Net::HTTP).to receive(:get_response).with(URI(PhotoAlbum::ENDPOINT))
      photo_album.request_photos
    end

    context 'when request is successful' do
      let(:parsed_body) {
        [
          {"albumId"=>4, "id"=>151, "title"=>"possimus dolor minima provident ipsam",
           "url"=>"https://via.placeholder.com/600/1d2ad4", "thumbnailUrl"=>"https://via.placeholder.com/150/1d2ad4"},
          {"albumId"=>4, "id"=>152, "title"=>"et accusantium enim pariatur eum nihil fugit",
           "url"=>"https://via.placeholder.com/600/a01c5b", "thumbnailUrl"=>"https://via.placeholder.com/150/a01c5b"},
          {"albumId"=>4, "id"=>153, "title"=>"eum laborum in sunt ea",
           "url"=>"https://via.placeholder.com/600/9da52c", "thumbnailUrl"=>"https://via.placeholder.com/150/9da52c"}
        ]
      }

      it 'returns an array photo ids and titles' do
        expected = [
          '[151] possimus dolor minima provident ipsam',
          '[152] et accusantium enim pariatur eum nihil fugit',
          '[153] eum laborum in sunt ea'
        ]

        expect(photo_album.request_photos).to eq(expected)
      end
    end

    context 'when request is not succesful' do
      let(:response) { Net::HTTPServiceUnavailable.new('1.1', 503, 'Service Unavailable') }

      it 'raises an error' do
        expect { photo_album.request_photos }.to raise_error(RuntimeError, 'Request failed with 503 Service Unavailable')
      end
    end
  end
end
