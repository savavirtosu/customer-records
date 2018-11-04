require './lib/geo/coordinates'
require './fetchers/customer_data_fetcher'
require './services/customer_service'
require './presenters/cli/customer_presenter'

class App
  attr_accessor :customer_service
  attr_accessor :city_coordinates, :city_name, :range, :filename

  def initialize
    @customer_service = CustomerService.new
    load_env
  end

  def run
    CustomerDataFetcher.new(@customer_service).load_from_file(@filename)
    customers = @customer_service.customers_in_range(city_coordinates, @range)
    CLI::CustomerPresenter.new(customers, @city_name, @range).print
  end

  private

  def load_env
    @city_coordinates = Geo::Coordinates.new(ENV['CITY_COORDINATES_LON'], ENV['CITY_COORDINATES_LNG'])
    @city_name = ENV['CITY_NAME']
    @range = ENV['RANGE']
    @filename = ENV['CUSTOMERS_FILENAME']
  end
end
