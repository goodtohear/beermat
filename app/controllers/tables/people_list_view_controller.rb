class PeopleListViewController < UITableViewController
  def initWithNight night
    if init
      @night = night
    end
    self
  end
  
  def viewDidLoad
    navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem UIBarButtonSystemItemAdd, target:self, action:'addFriend' 
  end
  
  def addFriend
    picker = ABPeoplePickerNavigationController.alloc.init
    picker.peoplePickerDelegate = self
    self.presentModalViewController picker, animated:true
    picker.navigationItem.leftBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem UIBarButtonSystemItemAdd, target:self, action:'addNewContact' 
  end
  
  def addNewContact
    maker = ABNewPersonViewController.alloc.init
    maker.newPersonViewDelegate = self
    newNavigationController = UINavigationController.alloc.initWithRootViewController:maker
    self.presentModalViewController newNavigationController, animated: true
  end
  
  def peoplePickerNavigationController picker, shouldContinueAfterSelectingPerson: person
    name = ABRecordCopyValue(person, kABPersonLastNameProperty)

    NSLog "Selected #{person.inspect}, #{name}"
    true
  end
  
  def peoplePickerNavigationController picker, shouldContinueAfterSelectingPerson: person, property:property, identifier:identifier
    NSLog "Selected #{person.inspect}, property: #{property}, identifier: #{identifier}"
    # @night.friends << person
    # self.dismissModalViewControllerAnimated true
    true
  end
  
  def peoplePickerNavigationControllerDidCancel picker
     self.dismissModalViewControllerAnimated true
  end
  
  CELL_ID = "CELL"
  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editing_style, forRowAtIndexPath:indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      friend = @night.friends[indexPath.row]
      @night.friends.delete friend
      tableView.deleteRowsAtIndexPaths [indexPath], withRowAnimation:UITableViewRowAnimationFade
      Night.save!
    end
  end
  
  def tableView tableView, cellForRowAtIndexPath:indexPath
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      cell = NoteCell.alloc.init
    end
    friend =  @night.friends[indexPath.row]
    # cell.photo.image = UIImage.imageNamed "link.png"
    cell.label.text = friend.name
    cell
  end
  
  def numberOfSectionsInTableView tableView
    1
  end
  
  def tableView tableView, numberOfRowsInSection: section
    @night.friends.count
  end 
  
  def tableView tableView, didSelectRowAtIndexPath:indexPath
    @night.friends[indexPath.row].show
    # tableView.deselectRowAtIndexPath indexPath, animated: true
  end
end