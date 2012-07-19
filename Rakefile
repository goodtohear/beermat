# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'motion-cocoapods'
require 'bubble-wrap'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Notes'
  app.frameworks += ['QuartzCore','AddressBook','AddressBookUI']
  app.codesign_certificate = 'iPhone Developer: Michael Forrest (2Y46T85LFL)'
  app.icons << 'icon_114.png'
  app.prerendered_icon = true
  app.info_plist['UIStatusBarStyle'] = 'UIStatusBarStyleBlackOpaque'

  app.pods do
    dependency 'SVWebViewController'
    dependency 'TapkuLibrary'
  end
  
end
