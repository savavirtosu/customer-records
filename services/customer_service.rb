require './models/customer'
require './lib/geo/calculator'
require './lib/geo/coordinates'
require './repositories/in_memory/customer_repository'

class CustomerService
  attr_accessor :customer_repo

  def initialize(customer_repo = InMemory::CustomerRepository.new)
    @customer_repo = customer_repo
  end

  def create_customer(hash)
    coordinates = Geo::Coordinates.from_json(hash)
    customer = Customer.new(hash['name'], hash['user_id'], coordinates)
    @customer_repo.save(customer)
  end

  def customers_in_range(city_coordinates, range)
    customer_repo.ordered_customers.select { |c| Geo::Calculator.new.distance_between(c.coordinates, city_coordinates).round <= range.to_i }
  end
end
