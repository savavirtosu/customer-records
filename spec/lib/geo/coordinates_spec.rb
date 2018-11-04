require './lib/geo/coordinates'

describe Geo::Coordinates do
  describe 'initilizer' do
    it 'converts lat & lng to float' do
      obj = Geo::Coordinates.new('32.9697', '-96.80322')
      expect(obj.lat).to eq(32.9697)
      expect(obj.lng).to eq(-96.80322)
    end

    it 'sets lat & lng to nil if no vaue given' do
      obj = Geo::Coordinates.new
      expect(obj.lat).to eq(nil)
      expect(obj.lng).to eq(nil)
    end
  end

  describe '::from_json' do
    let(:data) { { 'latitude' => 1, 'longitude' => 2 } }

    it 'return a new object' do
      returned_object = Geo::Coordinates.from_json(data)
      expect(returned_object.class).to eq(Geo::Coordinates)
    end

    it 'return a new object with right data' do
      returned_object = Geo::Coordinates.from_json(data)
      expect(returned_object.lat).to eq(1)
      expect(returned_object.lng).to eq(2)
    end
  end

  describe '#latitude=' do
    subject { Geo::Coordinates.new(0, 0) }

    it 'sets new latitude' do
      subject.latitude = 1
      expect(subject.latitude).to eq(1)
    end

    it 'sets new latitude and converts to float' do
      subject.latitude = '1'
      expect(subject.latitude).to eq(1)
    end
  end

  describe '#longitude=' do
    subject { Geo::Coordinates.new(0, 0) }

    it 'sets new longitude' do
      subject.longitude = 1
      expect(subject.longitude).to eq(1)
    end

    it 'sets new longitude and converts to float' do
      subject.longitude = '1'
      expect(subject.longitude).to eq(1)
    end
  end
end
