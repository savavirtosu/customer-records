require './repositories/in_memory/customer_repository'

describe InMemory::CustomerRepository do
  let(:customer) { double('Customer') }

  describe 'initilizer' do
    it 'sets an empty array as s default value' do
      expect(InMemory::CustomerRepository.new.customers).to eq([])
    end
  end

  describe '#save' do
    subject { InMemory::CustomerRepository.new }

    it 'saves the object in memory' do
      expect { subject.save(customer) }.to change { subject.customers.size }.from(0).to(1)
    end

    it 'saves method return true if everithing is ok' do
      expect(subject.save(customer)).to eq(true)
    end
  end

  describe '#ordered_customers' do
    let(:customer1) { double('Customer', user_id: 1) }
    let(:customer2) { double('Customer', user_id: 2) }
    subject { InMemory::CustomerRepository.new }

    before do
      subject.customers = [customer2, customer1]
    end

    it 'returns all customers' do
      expect(subject.ordered_customers.size).to eq(2)
    end

    it 'returns ordered customers' do
      expect(subject.ordered_customers).to eq([customer1, customer2])
    end
  end
end
