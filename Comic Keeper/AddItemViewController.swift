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
        newItemTextField.becomeFirstResponder()
        newItemTextField.delegate = self
        
        if !currentItem.isEmpty {
            newItemTextField.placeholder = ""
            newItemTextField.text = currentItem
        }
        
        title = viewTitle
        navigationItem.setHidesBackButton(true, animated: true)
        
        if viewTitle.contains("Variant") {
            newItemTextField.autocapitalizationType = .none
        } else {
            newItemTextField.autocapitalizationType = .words
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newItemTextField.resignFirstResponder()
        chooseSegueToPerform()
        return true
    }
    
    func chooseSegueToPerform() {
        if viewTitle.contains("Variant") {
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
