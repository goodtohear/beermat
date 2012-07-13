class LinksListViewController < UITableViewController
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
    end
  end
  
  def tableView tableView, cellForRowAtIndexPath:indexPath
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      cell = NoteCell.alloc.init
    end
    note =  @night.notes[indexPath.row]
    cell.icon.image = UIImage.imageNamed "link.png"
    cell.label.text = note.text
    cell
  end
  
  def numberOfSectionsInTableView tableView
    1
  end
  
  def tableView tableView, numberOfRowsInSection: section
    @night.notes.count
  end 
  
  def tableView tableView, didSelectRowAtIndexPath:indexPath
    @night.notes[indexPath.row].open
    tableView.deselectRowAtIndexPath indexPath, animated: true
  end
    
end