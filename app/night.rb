class Night < NSObject
  def initialize(options={})
    
  end
  
  def self.all
    @all ||= 3.times.map do
      Night.new
    end
    @all
  end
  def dateText
    "12 June 2012"
  end
end