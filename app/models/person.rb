class Person < NSObject
  attr_accessor :name
  def initialize(options={})
    @name = "Some Name"
  end

end