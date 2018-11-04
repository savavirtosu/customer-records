module InMemory
  class CustomerRepository
    attr_accessor :customers

    def initialize(customers = [])
      @customers = customers
    end

    def save(customer)
      @customers << customer
      true
    end

    def ordered_customers
      @customers.sort_by(&:user_id)
    end
  end
end
