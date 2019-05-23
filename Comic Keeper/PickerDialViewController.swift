//
//  PickerDialViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/19/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerDialViewController: UIViewController, StandardPicker  {
    
    @IBOutlet weak var currentItemLabel: UILabel!
    @IBOutlet weak var itemPicker: UIPickerView!
    
    var itemList: [String]!
    var selectedItemName: String!
    var pickerTitle: String!
    
    @IBAction func doneButton(_ sender: Any) {
        performSegue(withIdentifier: "ChooseItemSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pickerTitle
        currentItemLabel.text = "Original Value: \(selectedItemName!)"
        
        let selectedItemRow = itemList.firstIndex(of: selectedItemName)
        itemPicker.selectRow(selectedItemRow!, inComponent: 0, animated: true)
        
        navigationItem.setHidesBackButton(true, animated: true)
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

extension PickerDialViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItemName = itemList[row]
    }
}
