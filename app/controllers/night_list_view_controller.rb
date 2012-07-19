class NightListViewController < UIViewController
  # def loadView
  #   self.view = UIView.alloc.initWithFrame UIScreen.mainScreen.bounds
  # end
  
  def layout
    return unless @night_summaries
    x = 0
    for night_summary_controller in @night_summaries
      night_summary_controller.view.frame = [[x, 0], [320,400]]
      x += 320
    end
    @scroller.contentSize = [320 * @night_summaries.count, 400]
  end
  
  def add_night_summary_view night
    night_summary_controller = NightSummaryViewController.alloc.initWithNight night
    night_summary_controller.delegate = self
    @night_summaries << night_summary_controller
    NSLog "Night summaries now #{@night_summaries}"
    @scroller.addSubview night_summary_controller.view 
  end
  
  def viewDidLoad
    view.autoresizesSubviews = false
    
    self.view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'wood_1.jpg'
    navigationItem.title = "Beer Mat"

    @scroller = UIScrollView.alloc.initWithFrame [[0,0], self.view.frame.size]
    @scroller.pagingEnabled = true
    @scroller.delegate = self
    self.view.addSubview @scroller

    addDateLabel
    updateLabel

     @night_summaries = []
    for night in Night.all
      add_night_summary_view night
    end
    layout
    
    @add_button = button_with_image 'add', position: [100,360]
    @add_button.when(UIControlEventTouchUpInside) do
      night = Night.new
      Night.all << night
      Night.save!
      add_night_summary_view night
    end
    
    @delete_button = button_with_image 'trash', position: [170,360]
    
    @delete_button.when(UIControlEventTouchUpInside) do
      night = selected_night
      NSLog "Selected night = #{night}"
      night_summary = @night_summaries.find{|s| s.night == night }
      UIView.animateWithDuration 0.3, animations: -> do
        night_summary.view.alpha = 0
      end, completion: -> (complete) do
        if complete
          NSLog "completed animation, removing view"
          # night_summary.view.removeFromSuperview
          NSLog "deleting summary"
          @night_summaries.delete night_summary
          NSLog "deleting night #{selected_night}"
          Night.all.delete selected_night
          Night.save!
          layout
        end
      end
    end
    
  end
  
  def selected_night
    index =  (@scroller.contentOffset.x / 320).round
    Night.all[index]
  end
  
  def addDateLabel
    @label = UILabel.alloc.initWithFrame [[0, 320], [320, 30]]
    @label.font = UIFont.fontWithName 'HelveticaNeue-Bold', size: 13
    @label.numberOfLines = 2
    @label.backgroundColor = UIColor.clearColor
    @label.textColor = UIColor.whiteColor
    @label.textAlignment = UITextAlignmentCenter
    self.view.addSubview @label
  end
  
  def updateLabel
    night = selected_night
    @label.text = "#{night.dateText}\n#{night.notesSummaryText}" + (night.friends.count == 0 ? "" : ", #{night.friendsSummaryText}")
  end

  def scrollViewDidEndDragging scrollView, willDecelerate: willDecelerate
    updateLabel
  end
  
  def scrollViewDidEndDecelerating scrollView
    updateLabel
  end
  
  
  BUTTON_SIZE = [44,44]
  
  def button_with_image image, position: position
    result = UIButton.buttonWithType UIButtonTypeCustom
    result.alpha = 0.7
    result.frame = [position, BUTTON_SIZE]
    result.setImage UIImage.imageNamed(image), forState: UIControlStateNormal
    self.view.addSubview result
    result
  end
  
  def editNight night
    links_view_controller = LinkListEditorController.alloc.initWithNight night
    navigationController.pushViewController links_view_controller, animated: true
  end
  def editFriends night
    friends_view_controller = PeopleListViewController.alloc.initWithNight night
    navigationController.pushViewController friends_view_controller, animated: true
  end
  
end