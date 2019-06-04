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
    
    @IBAction func doneAction(_ sender: Any) {
        newItemTextField.resignFirstResponder()
        chooseSegueToPerform()
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
        chooseSegueToPerform()
        return true
    }
    
    // MARK: - Helpers
    
    func configureNewItemTextField() {
        
        newItemTextField.becomeFirstResponder()
        newItemTextField.delegate = self
        
        if pickerTitle.contains("Variant") {
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = ""
            newItemTextField.text = selectedItemName
        } else if pickerTitle.contains("Purchase") {
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .decimalPad
            
            if selectedItemName.contains("none") {
                newItemTextField.placeholder = "Enter purchase amount"
            } else {
                newItemTextField.placeholder = ""
                newItemTextField.text = selectedItemName
            }
        } else if pickerTitle.contains("Sales") {
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .decimalPad
            
            if selectedItemName.contains("none") {
                newItemTextField.placeholder = "Enter sales amount"
            } else {
                newItemTextField.placeholder = ""
                newItemTextField.text = selectedItemName
            }
        } else {
            newItemTextField.autocapitalizationType = .words
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = "Enter name"
        }
    }
    
    func chooseSegueToPerform() {
        
        // TODO: Is this function required given there is only on exit segue for all cases?
        
        if pickerTitle.contains("Variant") {
            performSegue(withIdentifier: "EditedItem", sender: self)
            
        } else if  pickerTitle.contains("Purchase") {
            performSegue(withIdentifier: "EditedItem", sender: self)
            
        } else if  pickerTitle.contains("Sales") {
            performSegue(withIdentifier: "EditedItem", sender: self)
            
        } else if  pickerTitle.contains("Publisher") {
            performSegue(withIdentifier: "EditedItem", sender: self)

        } else if  pickerTitle.contains("Series") {
            performSegue(withIdentifier: "EditedItem", sender: self)
            
        } else if  pickerTitle.contains("Condition") {
            performSegue(withIdentifier: "EditedItem", sender: self)
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddedItem" {
            // I don't think there is anything to do yet...
        } else if segue.identifier == "SectionHeadSegue" {
            let destination = segue.destination as! PickerHeaderViewController
            destination.hintText = hintText
        }
    }
    

}
