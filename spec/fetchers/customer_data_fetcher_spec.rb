require './fetchers/customer_data_fetcher'

describe CustomerDataFetcher do
  let(:customer_service) { instance_double('CustomerService') }
  let(:sample_data) do
    [
      { 'latitude' => '53.2451022', 'longitude' => '-6.238335', 'name' => 'Test User 2', 'user_id' => 2 },
      { 'latitude' => '51.92893', 'longitude' => '-10.27699', 'name' => 'Test User 1', 'user_id' => 1 }
    ]
  end

  describe 'initilizer' do
    it 'sets customer service' do
      expect(CustomerDataFetcher.new(customer_service).customer_service).to eq(customer_service)
    end
  end

  describe '#load_from_file' do
    subject { CustomerDataFetcher.new(customer_service).load_from_file(filename) }

    context 'invalid filename' do
      let(:filename) { 'invalid.txt' }
      it { expect { subject }.to raise_error(CustomerDataFetcherError) }
    end

    context 'valid filename' do
      let(:filename) { './spec/support/customers.txt' }

      it 'should call #create_customer on customer_service' do
        expect(customer_service).to receive(:create_customer).twice
        subject
      end

      it 'should call #create_customer on customer_service with sample data' do
        expect(customer_service).to receive(:create_customer).with(sample_data[0])
        expect(customer_service).to receive(:create_customer).with(sample_data[1])
        subject
      end
    end
  end
end
