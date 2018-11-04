class Customer
  attr_accessor :name, :user_id, :coordinates

  def initialize(name, user_id, coordinates)
    @name = name
    @user_id = user_id
    @coordinates = coordinates
  end
end