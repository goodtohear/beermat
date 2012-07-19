class NoteCell < UITableViewCell
  attr_accessor :icon, :label, :link_label
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
    
    @link_label = UITextView.alloc.initWithFrame [[40, 24], [244,20]]
    @link_label.backgroundColor = UIColor.clearColor
    @link_label.editable = false
    @link_label.userInteractionEnabled = false
    @link_label.font = UIFont.fontWithName "HelveticaNeue", size: 10
    addSubview @link_label
    
    
  end
  
end