#  HOWTO

This is a list of recipies that explain how to add features to Comic Keeper

## HOWTO Connect the _PickerTableViewController_ to an _EditComicBookViewControler_ Field

### Step One

Make sure you have a data source in ComicBookCollection. _PickerTableViewController_ expects a [String] to display as a list for the user to chose from.

    public var allPossibileConditions: [String] {
        return ["Very Poor", "Poor", "Good", "Very Good", "Fine", "Very Fine", "Perfect"]
    }

### Step Two

Add a _PickerTableViewController_ configuration segue case in _EditComicBookViewController_ prepare(for:sender:). This is called before the  _PickerTableViewController_ is displayed. The value of _listPickerKind_ is used to identify which field on _EditComicBookViewController_ is using the _PickerTableViewController_.

    case "ChooseConditionSegue":
        let pl = comicBookCollection.allPossibileConditions
        let si = currentComicBook?.book.condition
        configurePicker(kind: "Condition", pickerList: pl, selectedItem: si!)

### Step Three

Add a field update case in _EditComicBookViewController_ listPickerDidPickItem(). This is called after the user choose an item in _PickerTableViewController_ and before _EditComicBookViewController_ is displayed. Here you recieve the user's choice.

    } else if listPickerKind == "Condition" {
        conditionLabel.text = controller.selectedItemName
    }

### Step Four

Create a segue from the field in _EditComicBookViewController_ to the _PickerTableViewController_ to create a navigation connection. Give the segue the identifier you used in step two. When the user taps on the _EditComicBookViewController_ field the _PickerTableViewController_ will load with the proper configuration. In your storyboard control-drag from the _EditComicBookViewController_ _UITableViewCell_ to the _PickerTableViewController_ and select _Show (e.g. push)_.

    <connections>
        <segue destination="DeC-I5-iAl" kind="show" identifier="ChooseConditionSegue" id="EJW-N4-UEM"/>
    </connections>
    
## HOWTO Connect the _AddItemViewController_ to an _EditComicBookViewControler_ Field

### Step One

Add a _AddItemViewController_ configuration segue case in _EditComicBookViewController_ prepare(for:sender:). This is called before the  _AddItemViewController_ is displayed.

    case "EditPurchasePriceSegue":
        let controller = segue.destination as! AddItemViewController
        let i = currentComicBook?.comic.issueNumber
        controller.viewTitle = "#\(i!) Purchase Price"
        if let price = currentComicBook?.book.purchasePriceText {
            controller.currentItem = price
        }

### Step Two

Add a case to the unwind/exit seque _EditComicBookViewController_ addItemDidEditItem(). This is called after the user enters data in _AddItemViewController_ and before _EditComicBookViewController_ is displayed. Here you recieve the user's data. The value of _viewTitle_ is used to identify which field on _EditComicBookViewController_ is using the _AddItemViewController_.

    } else if controller.viewTitle.contains("Purchase") {
        purchasePriceLabel.text = newText
    }

### Step Three

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

### Step Four

Add an unwind/exit segue case to _AddItemViewController_ chooseSegueToPerform(). This is when the user taps _Done_ or presses _Enter_ on the keyboard. You will almost always want to perform the "EditedItem" segue which in turn calls _EditComicBookViewController_ addItemDidEditItem().

    } else if  viewTitle.contains("Purchase") {
       performSegue(withIdentifier: "EditedItem", sender: self)
    }
    
### Step Five

Create a segue from the field in _EditComicBookViewController_ to the _AddItemViewController_ to create a navigation connection. Give the segue the identifier you used in step one. When the user taps on the _EditComicBookViewController_ field the _PickerTableViewController_ will load with the proper configuration. In your storyboard control-drag from the _EditComicBookViewController_ _UITableViewCell_ to the _AddItemViewController_ and select _Show (e.g. push)_.

    <connections>
        <segue destination="Lbx-p7-yJ5" kind="show" identifier="EditPurchasePriceSegue" id="n8i-Re-5y0"/>
    </connections>




