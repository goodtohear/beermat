class Note < NSObject
  attr_accessor :text
  def initialize
    @text = "I am a note"
  end
  
  def open
    UIApplication.sharedApplication.openURL NSURL.URLWithString( "http://google.com")
  end
  
end