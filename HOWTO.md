# HOWTO

This is a list of recipes that explain how to add features to Comic Keeper

## HOWTO 1: Connect the _PickerTableViewController_ to an _EditComicBookViewController_ Field

### Step 1.1

Make sure you have a data source in ComicBookCollection. _PickerTableViewController_ expects a [String] to display as a list for the user to chose from.

    public var allPossibleConditions: [String] {
        return ["Very Poor", "Poor", "Good", "Very Good", "Fine", "Very Fine", "Perfect"]
    }

### Step 1.2

Add a _PickerTableViewController_ configuration segue case in _EditComicBookViewController_ prepare(for:sender:). This is called before the  _PickerTableViewController_ is displayed. The value of _listPickerKind_ is used to identify which field on _EditComicBookViewController_ is using the _PickerTableViewController_.

    case "ChooseConditionSegue":
        let pl = comicBookCollection.allPossibleConditions
        let si = currentComicBook?.book.condition
        configurePicker(kind: "Condition", pickerList: pl, selectedItem: si!)

### Step 1.3

Add a field update case in _EditComicBookViewController_ listPickerDidPickItem(). This is called after the user choose an item in _PickerTableViewController_ and before _EditComicBookViewController_ is displayed. Here you receive the user's choice.

    } else if listPickerKind == "Condition" {
        conditionLabel.text = controller.selectedItemName
    }

### Step 1.4

Create a segue from the field in _EditComicBookViewController_ to the _PickerTableViewController_ to create a navigation connection. Give the segue the identifier you used in step two. When the user taps on the _EditComicBookViewController_ field the _PickerTableViewController_ will load with the proper configuration. In your storyboard control-drag from the _EditComicBookViewController_ _UITableViewCell_ to the _PickerTableViewController_ and select _Show (e.g. push)_.

    <connections>
        <segue destination="DeC-I5-iAl" kind="show" identifier="ChooseConditionSegue" id="EJW-N4-UEM"/>
    </connections>

## HOWTO 2: Connect the _AddItemViewController_ to an _EditComicBookViewController_ Field

### Step 2.1

Add a _AddItemViewController_ configuration segue case in _EditComicBookViewController_ prepare(for:sender:). This is called before the  _AddItemViewController_ is displayed.

    case "EditPurchasePriceSegue":
        let controller = segue.destination as! AddItemViewController
        let i = currentComicBook?.comic.issueNumber
        controller.viewTitle = "#\(i!) Purchase Price"
        if let price = currentComicBook?.book.purchasePriceText {
            controller.currentItem = price
        }

### Step 2.2

Add a case to the unwind/exit segue _EditComicBookViewController_ addItemDidEditItem(). This is called after the user enters data in _AddItemViewController_ and before _EditComicBookViewController_ is displayed. Here you receive the user's data. The value of _viewTitle_ is used to identify which field on _EditComicBookViewController_ is using the _AddItemViewController_.

    } else if controller.viewTitle.contains("Purchase") {
        purchasePriceLabel.text = newText
    }

### Step 2.3

Add a configuration case to _AddItemViewController_ configureNewItemTextField(). This is called just before _AddItemViewController_ is loaded. Here you set the type of keyboard used, capitalization, placeholder text, and the text in the _newItemTextField_.

    } else if viewTitle.contains("Purchase") {
        newItemTextField.autocapitalizationType = .none
        newItemTextField.keyboardType = .decimalPad

        if currentItem.contains("none") {
            newItemTextField.placeholder = "Enter purchase amount"
        } else {
            newItemTextField.placeholder = ""
            newItemTextField.text = currentItem
        }
    }

### Step 2.4

Add an unwind/exit segue case to _AddItemViewController_ chooseSegueToPerform(). This is when the user taps _Done_ or presses _Enter_ on the keyboard. You will almost always want to perform the "EditedItem" segue which in turn calls _EditComicBookViewController_ addItemDidEditItem(). Note: the segue identifier is that of the unwind/exit segue!

    } else if  viewTitle.contains("Purchase") {
       performSegue(withIdentifier: "EditedItem", sender: self)
    }

### Step 2.5

Create a segue from the field in _EditComicBookViewController_ to the _AddItemViewController_ to create a navigation connection. Give the segue the identifier you used in step one. When the user taps on the _EditComicBookViewController_ field the _AddItemViewController_ will load with the proper configuration. In your storyboard control-drag from the _EditComicBookViewController_ _UITableViewCell_ to the _AddItemViewController_ and select _Show (e.g. push)_.

    <connections>
        <segue destination="Lbx-p7-yJ5" kind="show" identifier="EditPurchasePriceSegue" id="n8i-Re-5y0"/>
    </connections>
    
## HOWTO 3: Connect the _PickerDateViewController_ to an _EditComicBookViewController_ Field

### Step 3.1

Add a _PickerDateViewController_ configuration segue case in _EditComicBookViewController_ prepare(for:sender:). This is called before the  _PickerDateViewController_ is displayed.

    case "EditPurchaseDateSegue":
        let controller = segue.destination as! PickerDateViewController
        listPickerKind = "Purchase Date"
        controller.pickerTitle = listPickerKind
        controller.hintText = currentComicBook!.identifier
        if let purchaseDate = currentComicBook?.book.purchaseDate {
            controller.selectedItemDate = purchaseDate
        } else {
            controller.selectedItemDate = Date()
        }
        
### Step 3.2

Add a case to the unwind/exit segue _EditComicBookViewController_ datePickerDidPickDate(). This is called after the user picks a date in _PickerDateViewController_ and before _EditComicBookViewController_ is displayed. Here you receive the user's data. The value of _listPickerKind_ is used to identify which field on _EditComicBookViewController_ is using the _PickerDateViewController_.

    @IBAction func datePickerDidPickDate(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerDateViewController
        
        if listPickerKind == "Purchase Date" {
            purchaseDateLabel.text = controller.selectedItemName
        }
    }
    
### Step 3.3

Add an unwind/exit segue case to _PickerDateViewController_ doneButton(). This is when the user taps _Done_. You will almost always want to perform the "DatePickedSegue" segue which in turn calls _EditComicBookViewController_ datePickerDidPickDate(). Note: the segue identifier is that of the unwind/exit segue!

    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "DatePickedSegue", sender: self)
    }

### Step 3.4

Create a segue from the field in _EditComicBookViewController_ to the _PickerDateViewController_ to create a navigation connection. Give the segue the identifier you used in step one. When the user taps on the _EditComicBookViewController_ field the _PickerDateViewController_ will load with the proper configuration. In your storyboard control-drag from the _EditComicBookViewController_ _UITableViewCell_ to the _PickerDateViewController_ and select _Show (e.g. push)_.

If this is the first use case don't forget to create an unwind/exit segue from _PickerDateViewController_ to datePickerDidPickDate() in _EditComicBookViewController_.  In your storyboard control-drag the yellow circle (on the left) to the red circle (on the right) in the _Date Picker_ title bar and select datePickerDidPickDate().

    <connections>
        <segue destination="9C6-6i-qZ2" kind="show" identifier="EditDateSegue" id="OPf-sK-ccW"/>
        <segue destination="9C6-6i-qZ2" kind="show" identifier="EditPurchaseDateSegue" id="OPf-sK-ccW"/>
    </connections>
    
## HOWTO 4: Connect any Picker View Controller to an _PickerHeaderViewController_

The enabled all pickers to share a standard header which include a cover thumbnail image and a hint text label. It gives the user a sense of which comic book she is working with during editing. It also reduced repetitive code and controls by embedding the _PickerHeaderViewController_ within _UIContainerView_ and sharing data through an embed segue.

### Step 4.1

On the main storyboard disconnect and delete any outlets and controllers if the target picker view currently has a header. Delete references to these outlets in the pickers code.

### Step 4.2

Add a UIContainerView to the picker's view controller at its top. The container view should fill the width of the target view controller and be 160 points in height. Set the following contraints on the container view: top 0, left 0, right 0, height 160. Add a constraint to connect the top of the picker's first control to the bottom of the container view. All constraint warnings should be cleared.

### Step 4.3

Control drag from the container view in the target picker to the _PickerHeaderViewController_ in the main storyboard. Selected the embed segue. Give that that embed segue an ID that you will use later in the code for the picker's view controller's _prepare(for:sender:)_ function.

### Step 4.4

Add a _PickerHeaderViewController_ configuration segue case in the target picker's prepare(for:sender:) function. This is called before the  _PickerHeaderViewController_ is displayed.

    if segue.identifier == "SectionHeadSegue2" {
        let destination = segue.destination as! PickerHeaderViewController
        destination.hintText = hintText
    }



