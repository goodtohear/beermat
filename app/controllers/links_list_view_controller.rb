class LinksListViewController < UITableViewController
  def initWithNight(night)
    if init
      @night = night
      tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched
    end
    self
  end
  CELL_ID = "CELL"
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