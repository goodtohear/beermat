class Note < NSObject
  attr_accessor :text, :link
  def initialize options={}
    @text = options[:text] or "I am a note"
    @link = options[:link] or ""
  end
  def to_object
    {
      text: @text,
      link: @link.to_s
    }
  end
  def open
    UIApplication.sharedApplication.openURL NSURL.URLWithString( "http://google.com")
  end
  
end