class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
     @controller = NightListViewController.alloc.init
     @navigation = NavigationController.alloc.initWithRootViewController @controller
     @navigation.navigationBar.barStyle = UIBarStyleBlackOpaque
     @window.rootViewController = @navigation
     
     if launchOptions
       notification = launchOptions.objectForKey UIApplicationLaunchOptionsLocalNotificationKey
       NSLog "Notification? #{notification}"
     end 
     

     
     
     @window.makeKeyAndVisible
     true
  end
  
  def applicationDidBecomeActive application
    
  end
 
  
end
