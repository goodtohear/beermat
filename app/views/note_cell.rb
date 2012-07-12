class NoteCell < UITableViewCell
  attr_accessor :icon, :label
  def init
    build if super
    self 
  end
  def build
    self.accessoryType = 1 # UIUITableViewCellAccessoryDisclosureIndicator
    self.selectionStyle = 2 # UITableViewCellSelectionStyleGray
    @icon = UIImageView.alloc.initWithFrame [[16,10], [24,24]]
    addSubview @icon
    
    @label = UITextView.alloc.initWithFrame [[40, 6], [244,34]]
    @label.backgroundColor = UIColor.clearColor
    @label.editable = false
    @label.userInteractionEnabled = false
    @label.font = UIFont.fontWithName "HelveticaNeue", size: 13
    addSubview @label
    
    
  end
  
end