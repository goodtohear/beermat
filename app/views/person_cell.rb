class PersonCell < UITableViewCell
  attr_accessor :photo, :label
  def init
    build if super
    self 
  end
  def build
    self.accessoryType = 1 # UIUITableViewCellAccessoryDisclosureIndicator
    self.selectionStyle = 2 # UITableViewCellSelectionStyleGray
    @photo = UIImageView.alloc.initWithFrame [[0,0], [48,48]]
    addSubview @photo
    
    @label = UITextView.alloc.initWithFrame [[40, 6], [244,34]]
    @label.backgroundColor = UIColor.clearColor
    @label.editable = false
    @label.userInteractionEnabled = false
    @label.font = UIFont.fontWithName "HelveticaNeue", size: 16
    addSubview @label
    
    
  end
  
  
end