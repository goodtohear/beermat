class LinksListViewController < UITableViewController
  attr_accessor :delegate
  def initWithNight(night)
    if init
      @night = night
      tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched
    end
    self
  end
  
  CELL_ID = "CELL"
  def tableView(tableView, editingStyleForRowAtIndexPath:indexPath)
    UITableViewCellEditingStyleDelete
  end

  def tableView(tableView, commitEditingStyle:editing_style, forRowAtIndexPath:indexPath)
    if editing_style == UITableViewCellEditingStyleDelete
      note = @night.notes[indexPath.row]
      @night.notes -= [note]
      tableView.deleteRowsAtIndexPaths [indexPath], withRowAnimation:UITableViewRowAnimationFade
      Night.save!
    end
  end
  
  def tableView tableView, cellForRowAtIndexPath:indexPath
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      cell = NoteCell.alloc.init
    end
    note =  @night.notes[indexPath.row]
    cell.icon.image = UIImage.imageNamed note.link == "" ? "search" : "link"
    cell.label.text = note.text
    cell.link_label.text = note.link
    cell
  end
  
  def numberOfSectionsInTableView tableView
    1
  end
  
  def tableView tableView, numberOfRowsInSection: section
    @night.notes.count
  end 
  
  def tableView tableView, didSelectRowAtIndexPath:indexPath
    # @night.notes[indexPath.row].open
    tableView.deselectRowAtIndexPath indexPath, animated: true
    @note = @night.notes[indexPath.row] 
    @link_finder = SVWebViewController.alloc.initWithAddress "http://google.com/search?q=#{@note.text.stringByAddingPercentEscapesUsingEncoding NSUTF8StringEncoding}"  # LinkFinderViewController.alloc.initWithNote 
    accept = UIBarButtonItem.alloc.initWithTitle "Save link", style: UIBarButtonItemStyleDone,  target:self, action: 'acceptLink'
    @link_finder.navigationItem.rightBarButtonItem = accept
    delegate.navigationController.pushViewController @link_finder, animated: true
  end
  def acceptLink
    # @note.link = 
    link = @link_finder.view.request.URL.absoluteString
    NSLog "accepting link #{link} in note #{@note}"
    @note.link = link
    Night.save!
    delegate.navigationController.popViewControllerAnimated true
    tableView.reloadData
  end
end