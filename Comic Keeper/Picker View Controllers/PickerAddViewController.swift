//
//  AddItemViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/17/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerAddViewController: UIViewController, UITextFieldDelegate, StandardPicker {
    @IBOutlet weak var newItemTextField: UITextField!
    
    var itemList: [String]!
    var selectedItemName: String!
    var pickerTitle: String!
    var hintText: String!
    var coverImage: UIImage!
    var noneButtonVisible: Bool!
    var viewID: ViewIdentifer!
    
    @IBAction func doneAction(_ sender: Any) {
        newItemTextField.resignFirstResponder()
        performSegue(withIdentifier: "EditedItem", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // show the keyboard by default
        title = pickerTitle
        configureNewItemTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newItemTextField.resignFirstResponder()
        performSegue(withIdentifier: "EditedItem", sender: self)
        return true
    }
    
    // MARK: - Helpers
    
    private func configureTextFieldForNumbers(prompt: String) {
        newItemTextField.autocapitalizationType = .none
        newItemTextField.keyboardType = .decimalPad
        
        if selectedItemName.contains("none") {
            newItemTextField.placeholder = prompt
        } else {
            newItemTextField.placeholder = ""
            newItemTextField.text = selectedItemName
        }
    }
    
    private func configureNewItemTextField() {
        
        newItemTextField.becomeFirstResponder()
        newItemTextField.delegate = self
        
        guard let pickerTitle = pickerTitle else {
            fatalError("pickerTitle in PickerAddViewControler is nil!")
        }
        
        switch pickerTitle {
            
        case let name where name.contains("Variant"):
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = ""
            newItemTextField.text = selectedItemName
            
        case let name where name.contains("Purchase"):
            configureTextFieldForNumbers(prompt: "Enter purchase amount")
 
        case let name where name.contains("Sales"):
            configureTextFieldForNumbers(prompt: "Enter sales amount")

        default:
            newItemTextField.autocapitalizationType = .words
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = "Enter name"
        }
    }
    
    private func validateData() {
        // TODO: if data is supposed to represent a dollar amount, make sure it can be parsed and put it into the the 0.00 format.
        // TODO: If the data can't be parsed then alert the user and ask her what to do: edit the value or leave it unchanged and go on to the next view.
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        validateData()
        
        if segue.identifier == "SectionHeadSegue" {
            let destination = segue.destination as! PickerHeaderViewController
            destination.hintText = hintText
        }
    }
}
