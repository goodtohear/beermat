class NotesHeaderView < UIView
  attr_accessor :title
  
  def init
    if super
      @textLabel = UILabel.alloc.initWithFrame [[10,0],[280,30] ]
      @textLabel.backgroundColor = UIColor.clearColor
      @textLabel.textColor = UIColor.whiteColor
      addSubview @textLabel
    end
  end
  
  def title= text
    @textLabel.text = text
  end
  
end