//
//  AddItemViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/17/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var newItemTextField: UITextField!
    
    var viewTitle = "Add Item"
    var currentItem = ""
    
    @IBAction func doneAction(_ sender: Any) {
        newItemTextField.resignFirstResponder()
        chooseSegueToPerform()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // show the keyboard by default
        title = viewTitle
        navigationItem.setHidesBackButton(true, animated: true)
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
        
        if viewTitle.contains("Variant") {
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = ""
            newItemTextField.text = currentItem
        } else if viewTitle.contains("Purchase") {
            newItemTextField.autocapitalizationType = .none
            newItemTextField.keyboardType = .decimalPad
            
            if currentItem.contains("none") {
                newItemTextField.placeholder = "Enter purchase amount"
            } else {
                newItemTextField.placeholder = ""
                newItemTextField.text = currentItem
            }
        } else {
            newItemTextField.autocapitalizationType = .words
            newItemTextField.keyboardType = .default
            newItemTextField.placeholder = "Enter name"
        }
    }
    
    func chooseSegueToPerform() {
        
        if viewTitle.contains("Variant") {
            performSegue(withIdentifier: "EditedItem", sender: self)
        } else if  viewTitle.contains("Purchase") {
            performSegue(withIdentifier: "EditedItem", sender: self)
        } else {
            performSegue(withIdentifier: "AddedItem", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddedItem" {
            // I don't think there is anything to do yet...
        }
    }
    

}
