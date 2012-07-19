class NightListViewController < UIViewController
  attr_reader :selected_night
  
  def coverflowView coverflowView, coverAtIndex:index
    night = Night.all[index]
    result = NightSummaryView.alloc.initWithFrame [[0,0], [280,280]], night: night
    result.delegate = self
    result
  end
  def coverflowView coverflowView, coverAtIndexWasBroughtToFront: index
    NSLog "Selected cover at index #{index}"
    @selected_night =Night.all[index]
    updateLabel
  end
  def viewDidLoad
    
    self.view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'wood_1.jpg'
    navigationItem.title = "Beer Mat"

    @cover_flow = TKCoverflowView.alloc.initWithFrame [[0,0],[320,320]]
    @cover_flow.coverflowDelegate = self
    @cover_flow.dataSource = self
    @cover_flow.coverSpacing = 100
    
    
    
    view.addSubview @cover_flow

    reload
   
    addDateLabel
    updateLabel

    @add_button = button_with_image 'add', position: [100,360]
    @add_button.when(UIControlEventTouchUpInside) do
      night = Night.new
      Night.all.unshift night
      Night.save!
      reload
    end
    
    @delete_button = button_with_image 'trash', position: [170,360]
    
    @delete_button.when(UIControlEventTouchUpInside) do
      night = selected_night
      Night.all.delete selected_night
      Night.save!
      reload
    end
    
  end
  def reload
    @cover_flow.numberOfCovers = Night.all.count
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
    return unless @label
    night = selected_night
    @label.text = "#{night.dateText}\n#{night.notesSummaryText}" + (night.friends.count == 0 ? "" : ", #{night.friendsSummaryText}")
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