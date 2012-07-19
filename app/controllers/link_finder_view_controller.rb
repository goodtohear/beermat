class LinkFinderViewController < UIViewController
  def initWithNote note
    if init
      @note = note
    end
    self
  end
  def viewDidLoad
    @webview = UIWebView.alloc.initWithFrame [[0,0],view.frame.size]
    view.addSubview @webview
    @webview.loadRequest NSURLRequest.requestWithURL NSURL.URLWithString "http://google.com/search?q=#{@note.text}"
    
    
    @accept = UIBarButtonItem.alloc.initWithTitle "Save link", style: UIBarButtonItemStyleDone,  target:self, action: 'acceptLink'
    
    navigationItem.rightBarButtonItem = @accept
    
  end
  def acceptLink
    # @note.link = 
  end
  
end