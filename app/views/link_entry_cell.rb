class LinkEntryCell < UITableViewCell
  def init
    build if super
    self
  end
  def build
    @label = UILabel.alloc.initWithFrame [[0,0],[320,90]]
    @label.text = "Add some text, bitch"
    addSubview @label
    
  end
end