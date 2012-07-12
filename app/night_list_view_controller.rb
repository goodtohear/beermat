class NightListViewController < UIViewController
  def loadView
    self.view = UIView.alloc.initWithFrame UIScreen.mainScreen.bounds
  end
  
  def viewDidLoad
    @scroller = UIScrollView.alloc.initWithFrame [[0,0], self.view.frame.size]
    @scroller.pagingEnabled = true
    self.view.addSubview @scroller
    self.view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'wood_1.jpg'
    @night_summaries = []
    x = 0
    for night in Night.all
      night_summary_controller = NightSummaryViewController.alloc.initWithNight night
      night_summary_controller.view.frame = [[x, 0], [320,400]]
      night_summary_controller.delegate = self
      @scroller.addSubview night_summary_controller.view 
      @night_summaries << night_summary_controller
      x += 320
    end
    @scroller.contentSize = [320 * Night.all.count, 400]
    
  end
  
  
end