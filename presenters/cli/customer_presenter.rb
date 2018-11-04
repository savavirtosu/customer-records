module CLI
  class CustomerPresenter
    attr_accessor :customers, :city_name, :range
    def initialize(customers, city_name, range)
      @customers = customers
      @city_name = city_name
      @range = range
    end

    def print(out = $stdout)
      out.puts "Customers within #{@range.to_i/1000}km range of #{@city_name}:"
      @customers.each do |c|
        out.puts "#{c.user_id}: #{c.name}"
      end
      out.puts "Total in range = #{@customers.size}"
    end
  end
end
