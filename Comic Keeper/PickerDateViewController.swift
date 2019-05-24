//
//  PickerDateViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/24/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerDateViewController: UIViewController, StandardPicker {
    

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var itemList: [String]!
    var selectedItemName: String!
    var pickerTitle: String!
    var hintText: String!
    
    @IBAction func doneButton(_ sender: Any) {
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pickerTitle
        hintLabel.text = hintText
        
        if let selectedDate = createDate(from: selectedItemName) {
            datePicker.date = selectedDate
        }
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    /// Creates a Date object from a string formatted as yyyy-MM-dd.
    /// - Example: 2019-05-24
    func createDate(from s: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: s)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
