class Note < NSObject
  attr_accessor :text
  def initialize options={}
    @text = options[:text] or "I am a note"
  end
  def to_object
    {
      text: @text
    }
  end
  def open
    UIApplication.sharedApplication.openURL NSURL.URLWithString( "http://google.com")
  end
  
end