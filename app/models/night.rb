class Night < NSObject
  attr_accessor :notes
  def initialize(options={})
    @notes = 2.times.map do
      Note.new
    end
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