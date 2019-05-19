//
//  ChooseItemViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/19/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class ChooseItemViewController: UIViewController {
    
    @IBOutlet weak var currentItemLabel: UILabel!
    @IBOutlet weak var itemPicker: UIPickerView!
    
    var itemList: [String]!
    var selectedItemRow: Int!
    var selectedItemName: String!
    var pickerTitle: String!

    
    @IBAction func addItemButton(_ sender: Any) {
    }
    
    @IBAction func doneButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = pickerTitle
        currentItemLabel.text = selectedItemName
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
