require 'json'

class CustomerDataFetcherError < StandardError
end

class CustomerDataFetcher
  attr_accessor :customer_service

  def initialize(customer_service)
    @customer_service = customer_service
  end

  def load_from_file(filename)
    File.open(filename) do |file|
      file.each do |line|
        @customer_service.create_customer(JSON.parse(line))
      end
    end
  rescue
    raise CustomerDataFetcherError, 'Unable to fetch data from customers file'
  end
end
