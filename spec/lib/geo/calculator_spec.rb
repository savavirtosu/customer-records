require './lib/geo/calculator'

describe Geo::Calculator do
  describe '::distance_between' do
    context 'valid input' do
      let(:c1) { double('Geo::Coordinates', latitude: 32.9697, longitude: -96.80322) }
      let(:c2) { double('Geo::Coordinates', latitude: 29.46786, longitude: -98.53506) }

      before do
        allow(c1).to receive(:is_a?).and_return true
        allow(c2).to receive(:is_a?).and_return true
      end

      it 'distance to same point equal to 0' do
        expect(Geo::Calculator.new.distance_between(c1, c1)).to be_within(0.5).of(0)
      end

      it 'have the distance to same point equal to 0' do
        expect(Geo::Calculator.new.distance_between(c1, c2)).to be_within(0.5).of(422759)
      end
    end

    context 'invalid input' do
      it 'both coordinates invalid' do
        expect { Geo::Calculator.new.distance_between(nil, nil) }.to raise_error(Geo::CalculatorError)
      end

      it 'first coordinates invalid' do
        c = double('Geo::Coordinates', latitude: 1, longitude: 2)
        expect { Geo::Calculator.new.distance_between(nil, c) }.to raise_error(Geo::CalculatorError)
      end

      it 'second coordinates invalid' do
        c = double('Geo::Coordinates', latitude: 1, longitude: 2)
        expect { Geo::Calculator.new.distance_between(c, nil) }.to raise_error(Geo::CalculatorError)
      end
    end
  end
end
