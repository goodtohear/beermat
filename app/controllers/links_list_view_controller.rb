class LinksListViewController < UITableViewController
  ENTRY_SECTION = 0
  
  def initWithNight(night)
    if init
      @night = night
      @entry_cell = LinkEntryCell.alloc.init
      navigationItem.title = @night.dateText
      view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'wood_1.jpg'
      tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    end
    self
  end
  CELL_ID = "CELL"
  def tableView tableView, cellForRowAtIndexPath:indexPath
    return @entry_cell if indexPath.section == ENTRY_SECTION
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_ID) || begin
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:CELL_ID)
    end
    note =  @night.notes[indexPath.row]
    cell.textLabel.text = note.text
    cell
  end
  
  def numberOfSectionsInTableView tableView
    2
  end
  
  def tableView tableView, viewForHeaderInSection: section
    result =  NotesHeaderView.alloc.init
    result.title = tableView tableView, titleForHeaderInSection: section
    result
  end
  
  def tableView tableView, heightForHeaderInSection: section
    return 30
  end
  
  def tableView tableView, titleForHeaderInSection: section
    return "Take a note here:" if section == ENTRY_SECTION 
    "Notes:"
  end
  
  def tableView tableView, numberOfRowsInSection: section
    section == ENTRY_SECTION ? 1 : @night.notes.count
  end  
  
  def tableView tableView, heightForRowAtIndexPath: indexPath
    return @entry_cell.frame.size.height if indexPath.section == ENTRY_SECTION
    super
  end
  
end