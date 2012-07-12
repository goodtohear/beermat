class BeerMatView < UIImageView
  def initWithFrame frame, night: night
    if initWithFrame frame
      @night = night
      build
    end
    self
  end
  
  def build
    self.backgroundColor = UIColor.grayColor  
    self.layer.cornerRadius = 10.0
    self.layer.shadowRadius = 3.0
    self.layer.shadowColor = UIColor.blackColor.CGColor
    self.layer.shadowOpacity = 0.2
    self.layer.shouldRasterize = true
    self.layer.masksToBounds = true
  end
  
end