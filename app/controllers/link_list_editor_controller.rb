class LinkListEditorController < UIViewController
  def initWithNight night
    if init
      @night = night
      view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'cardboard.png'
      build
      navigationItem.title = @night.dateText
      navigationItem.leftBarButtonItem = @table.editButtonItem
      navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem UIBarButtonSystemItemSave, target:self, action:'done' 
    end
    self
  end
  def done
    navigationController.popViewControllerAnimated true
  end
  def build
    @table = LinksListViewController.alloc.initWithNight @night
    @table.view.backgroundColor = UIColor.colorWithPatternImage UIImage.imageNamed 'cardboard.png'
    @table.view.frame = [[0,0], [320,156+44 ]]
    view.addSubview @table.view
    
    text_field_background = UIView.alloc.initWithFrame [[0, 220 - 44 - 20], [320,44]]
    text_field_background.backgroundColor = UIColor.blackColor
    text_field_background.alpha = 0.3
    view.addSubview text_field_background
    
    @input = UITextField.alloc.initWithFrame [[6,227 - 44 - 20], [230,32]]
    @input.layer.cornerRadius = 5.0
    @input.placeholder = "Add a new note..."
    @input.backgroundColor = UIColor.whiteColor
    @input.borderStyle = UITextBorderStyleBezel
    view.addSubview @input
    @input.becomeFirstResponder
    @input.delegate = self

  
    @save_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @save_button.frame = [[245,227 - 44 - 20], [64, 32]]

    @save_button.setTitle("Save", forState: UIControlStateNormal)
    view.addSubview @save_button
    
    
    @save_button.when(UIControlEventTouchUpInside) do
      save!
    end
    
  end
  def save!
    return if @input.text == ""
    note = Note.new
    note.text = @input.text
    @night.notes << note
    path = NSIndexPath.indexPathForRow( @night.notes.count - 1, inSection: 0)
    @table.tableView.insertRowsAtIndexPaths [path], withRowAnimation:UITableViewRowAnimationAutomatic
    @table.tableView.scrollToRowAtIndexPath path, atScrollPosition:UITableViewScrollPositionTop, animated:true
    @input.text = ""
  end
  
  def textField textField, shouldChangeCharactersInRange:range, replacementString: string
    @save_button.enabled = string != ""
    true
  end
  def textFieldShouldReturn(textfield)
    save!
    true
  end
  
end