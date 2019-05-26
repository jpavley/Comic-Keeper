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
    var selectedItemDate: Date!
    var pickerTitle: String!
    var hintText: String!
    var coverImage: UIImage!
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "DatePickedSegue", sender: self)
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        updateSelectedItemName(with: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pickerTitle
        hintLabel.text = hintText
        datePicker.date = selectedItemDate
        updateSelectedItemName(with: datePicker.date)
        
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func updateSelectedItemName(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        selectedItemName = dateFormatter.string(from: date)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}
