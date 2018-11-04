require './services/customer_service'

describe CustomerService do
  let(:repo) { instance_double('CustomerRepository') }

  describe 'initilizer' do
    it 'sets InMemory::CustomerRepository as a default repo' do
      expect(CustomerService.new.customer_repo.class.to_s).to eq('InMemory::CustomerRepository')
    end
  end

  describe '#create_customer' do
    subject { CustomerService.new(repo).create_customer(customer_hash) }
    let(:coordinates) { double('Geo::Coordinates') }
    let(:customer_hash) { { 'name' => 'test', 'user_id' => 88 } }

    before do 
      allow(Geo::Coordinates).to receive(:from_json).and_return(coordinates)
      allow(Customer).to receive(:new).with('test', 88, coordinates)
      allow(repo).to receive(:save).and_return(true)
    end

    it 'initilize a new Customer oject' do
      expect(Geo::Coordinates).to receive(:from_json).and_return(coordinates)
      expect(Customer).to receive(:new).with('test', 88, coordinates)
      subject
    end

    it 'save Customer object to the repository' do
      expect(repo).to receive(:save)
      subject
    end

    it 'returns the response form the respository' do
      allow(repo).to receive(:save).and_return(false)
      expect(subject).to eq(false)
    end
  end

  describe '#customers_in_range' do
    let(:city_coordinates) { double('Geo::Coordinates') }
    let(:range) { '10' }
    let(:customer1) { double('Customer', coordinates: double('Geo::Coordinates')) }
    let(:customer2) { double('Customer', coordinates: double('Geo::Coordinates')) }

    subject { CustomerService.new(repo).customers_in_range(city_coordinates, range) }

    before { allow(repo).to receive(:ordered_customers).and_return([customer1, customer2]) }

    context 'no customers in range' do
      before { allow_any_instance_of(Geo::Calculator).to receive(:distance_between).and_return(10.5) }
      it { expect(subject).to eq([]) }
    end

    context 'one customer in range' do
      before do
        allow_any_instance_of(Geo::Calculator).to receive(:distance_between).with(customer1.coordinates, city_coordinates).and_return(10.5)
        allow_any_instance_of(Geo::Calculator).to receive(:distance_between).with(customer2.coordinates, city_coordinates).and_return(10.4)
      end
      it { expect(subject).to eq([customer2]) }
    end

    context 'all customers in range' do
      before { allow_any_instance_of(Geo::Calculator).to receive(:distance_between).and_return(10.4) }
      it { expect(subject).to eq([customer1, customer2]) }
    end
  end
end
