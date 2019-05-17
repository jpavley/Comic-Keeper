//
//  PickerTableViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/15/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class PickerTableViewController: UITableViewController {
    
    var itemList: [String]!
    var selectedItemIndex = IndexPath()
    var selectedItemName: String!
    var pickerTitle: String!

    override func viewDidLoad() {
        
        func setSelectedItemIndex() {
            for i in 0..<itemList.count {
                if itemList[i] == selectedItemName {
                    selectedItemIndex = IndexPath(row: i, section: 0)
                    break
                }
            }
        }

        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        title = pickerTitle
        setSelectedItemIndex()
    }
        
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPickerCell", for: indexPath)

        // Configure the cell...
        let itemName = itemList![indexPath.row]
        cell.textLabel?.text = itemName
        
        // check mark management
        if itemName == selectedItemName {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != selectedItemIndex.row {
            
            if let newCell = tableView.cellForRow(at: indexPath) {
                newCell.accessoryType = .checkmark
            }
            
            if let oldCell = tableView.cellForRow(
                at: selectedItemIndex) {
                oldCell.accessoryType = .none
            }
            
            selectedItemIndex = indexPath
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickedItem" {
            // PickedItem is the identifier of the unwind segue.
            // The unwind segue triggers the action listPickerDidPickItem in
            // EditComicBookViewController.
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                selectedItemName = itemList[indexPath.row]
            }
        } else if segue.identifier == "AddItemSegue" {
            let destination = segue.destination as! AddItemViewController
            destination.viewTitle = "Add \(pickerTitle!)"

        }
    }
    

}
