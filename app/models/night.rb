class Night < NSObject
  attr_accessor :notes
  attr_accessor :friends
  
  
  def initialize(options={})
    
    @notes = parse options[:notes], class: Note, default: []
    @friends = parse options[:friends], class: Person, default: []
    
    #TODO: Save location
    
  end
  
  def parse items, class: cla, default: default
    return default unless items
    items.map do |item|
      cla.new item
    end
  end
  
  def self.all
    @all ||= load || [Night.new]
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
  
  def friendsSummaryText
    "#{friends.count} friend#{friends.count == 1 ? '' : 's'}"
  end
  def notesSummaryText
    "#{notes.count} note#{notes.count == 1 ? '' : 's'}"
  end
  
  def self.save!
    NSLog "Saving"
    App::Persistence['nights'] = all.map(&:to_object)
  end
  
  def to_object
    {
      notes: @notes.map(&:to_object),
      title: dateText
    }
  end
  
  
end