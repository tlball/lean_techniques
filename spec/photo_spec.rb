require 'spec_helper'

describe Photo do
  let(:photo) { Photo.new('id' => 1, 'title' => 'my great photo') }

  describe 'to_s' do
    it "outputs the photo's id and title" do
      expect(photo.to_s).to eq('[1] my great photo')
    end
  end
end
