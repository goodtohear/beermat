class NightSummaryViewController < UIViewController
  attr_accessor :delegate
  
  BUTTON_SIZE = [120,120]
  
  def loadView
    self.view = UIView.alloc.initWithFrame [[0,0], [320,400]]
  end
  def viewDidLoad
    addBeerMatView
    addDateLabel
    addPhotoButton
    addListButton
    addEmailButton
    addPeopleButton
    
  end
  def addBeerMatView
    @mat = BeerMatView.alloc.initWithFrame [[20,20], [280,280]], night: @night
    self.view.addSubview @mat
  end
  
  def button_with_image image, position: position
    result = UIButton.buttonWithType UIButtonTypeCustom
    result.alpha = 0.7
    result.frame = [ position.map{|v| v + 30}    ,BUTTON_SIZE]
    result.setImage UIImage.imageNamed(image), forState: UIControlStateNormal
    view.addSubview result
    result
  end
  
  def addListButton
    @list_button = button_with_image "list", position: [0, 0]
    @list_button.when(UIControlEventTouchUpInside) do
      UIView.animateWithDuration 0.5, animations: -> do
        t = CATransform3DMakeRotation Math::PI, 0.0, 1.0, 0.0
      end, completion: ->(complete) do
        delegate.editNight @night if complete
      end
    end
  end
  def addEmailButton
    @email_button = button_with_image 'email', position: [140, 140]
  end
  def addPeopleButton
    @people_button = button_with_image 'people', position: [140, 0]
  end
  def addPhotoButton
    @photo_button = button_with_image 'camera', position: [0,140]
    @photo_button.when(UIControlEventTouchUpInside) do
      showImagePicker self
    end
  end
  
  
  def addDateLabel
    NSLog "Adding the date label"
    @dateLabel = UILabel.alloc.initWithFrame [[0, 320], [320, 16]]
    @dateLabel.font = UIFont.fontWithName 'HelveticaNeue-Bold', size: 13
    @dateLabel.text = @night.dateText
    @dateLabel.backgroundColor = UIColor.clearColor
    @dateLabel.textColor = UIColor.whiteColor
    @dateLabel.textAlignment = UITextAlignmentCenter
    self.view.addSubview @dateLabel
  end
  
  
  def showImagePicker sender
    # Create and show the image picker.
    imagePicker = UIImagePickerController.alloc.init
    imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary 
    imagePicker.mediaTypes = [KUTTypeImage]
    imagePicker.delegate = self
    imagePicker.allowsImageEditing = false
    delegate.presentViewController imagePicker, animated:true, completion: -> do
      NSLog "Presented"
    end
  end
  
  # image picker delegate methods
  def imagePickerControllerDidCancel(picker)
    delegate.dismissViewControllerAnimated true, completion: -> do
    end
  end
  def imagePickerController(picker, didFinishPickingMediaWithInfo:info) 
    # I think presenting the picker is shifting the parent view up by -44 to cover the nav bar. 
    # Not sure how to prevent this. 
    mediaType = info[UIImagePickerControllerMediaType]
    if mediaType == KUTTypeImage
      editedImage = info[UIImagePickerControllerEditedImage]
      originalImage = info[UIImagePickerControllerOriginalImage]
      @mat.image = editedImage || originalImage
    end
    delegate.dismissViewControllerAnimated true, completion: -> do
    end
    
  end
 
  #
  def initWithNight night
    if init
      @night = night
    end
    self
  end
  
end