class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
     @controller = NightListViewController.alloc.init
     @navigation = NavigationController.alloc.initWithRootViewController @controller
     @navigation.navigationBar.barStyle = UIBarStyleBlackOpaque
     @window.rootViewController = @navigation
     
     @window.makeKeyAndVisible
     true
  end
end
