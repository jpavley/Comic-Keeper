//
//  PickerDialViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/19/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerDialViewController: UIViewController, StandardPicker  {
    
    @IBOutlet weak var itemPicker: UIPickerView!
    @IBOutlet weak var noneButton: UIButton!
    
    var itemList: [String]!
    var selectedItemName: String!
    var pickerTitle: String!
    var hintText: String!
    var coverImage: UIImage!
    var noneButtonVisible: Bool!
    
    @IBAction func doneButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "ChooseItemSegue", sender: self)
    }
    
    @IBAction func noneButtonAction(_ sender: Any) {
        selectedItemName = ""
        performSegue(withIdentifier: "ChooseItemSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pickerTitle
        noneButton.isHidden = !noneButtonVisible
        
        if let selectedItemRow = itemList.firstIndex(of: selectedItemName) {
            itemPicker.selectRow(selectedItemRow, inComponent: 0, animated: true)
        } else {
            itemPicker.selectRow(0, inComponent: 0, animated: true)
        }
        
        //navigationItem.setHidesBackButton(true, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SectionHeadSegue2" {
            let destination = segue.destination as! PickerHeaderViewController
            destination.hintText = hintText
        }
    }
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
