class Note < NSObject
  def initialize
    
  end
  def text
    "I am a note"
  end
  
  def open
    UIApplication.sharedApplication.openURL NSURL.URLWithString( "http://google.com")
  end
  
end