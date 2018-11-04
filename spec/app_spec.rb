require './app'

describe App do
  describe 'initilizer' do
    subject { App.new }
    it 'creates CustomerService' do
      expect(subject.customer_service).to_not be_nil
      expect(subject.customer_service).to be_a(CustomerService)
    end

    [:city_coordinates, :city_name, :range, :filename].each do |value|
      it { expect(subject.send(value)).to_not be_nil }
    end
  end

  describe '#run' do
    subject { App.new.run }

    it { expect { subject }.to output(/Test User 2/).to_stdout }
    it { expect { subject }.to_not output(/Test User 1/).to_stdout }
    it { expect { subject }.to output(/Total in range = 1/).to_stdout }
  end
end
