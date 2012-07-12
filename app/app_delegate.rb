class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
     @controller = NightListViewController.alloc.init
     @window.rootViewController = UINavigationController.alloc.initWithRootViewController @controller
     @window.makeKeyAndVisible
     true
  end
end
