class Night < NSObject
  attr_accessor :notes
  def initialize(options={})
    if options[:notes]  
      @notes = options[:notes].map do |item|
        Note.new item
      end
    else
      @notes = []
    end
  end
  
  def self.all
    @all ||= load || [Night.new]
    NSLog "All = #{@all}"
    @all
  end
  
  def self.load
    data = App::Persistence['nights']
    return nil unless data
    data.map do |item|
      Night.new item
    end
  end
  
  def dateText
    "12 June 2012"
  end
  
  def self.save!
    App::Persistence['nights'] = all.map(&:to_object)
  end
  
  def to_object
    {
      notes: @notes.map(&:to_object),
      title: dateText
    }
  end
  
end