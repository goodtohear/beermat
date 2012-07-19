class NavigationController < UINavigationController
  def pushViewController view_controller, animated: animated
    UIView.animateWithDuration 0.2, animations: -> do
      super view_controller, animated: false
      UIView.setAnimationTransition UIViewAnimationTransitionFlipFromRight, forView:self.view, cache:false
    end
  end
  def popViewControllerAnimated animated
    UIView.animateWithDuration 0.2, animations: -> do
      super false
      UIView.setAnimationTransition UIViewAnimationTransitionFlipFromLeft, forView: self.view, cache: false
    end
  end
end