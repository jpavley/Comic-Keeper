//
//  VariantsTableViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class VariantsTableViewController: UITableViewController {
    
    var comicBookCollection: ComicBookCollection!
    var currentPublisherName: String!
    var currentSeriesTitle: String!
    var currentIssueNumber: String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = currentSeriesTitle
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let variants = comicBookCollection.variantSignifiers(issueNumber: currentIssueNumber, seriesTitle: currentSeriesTitle, publisherName: currentPublisherName)
        return variants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariantCell", for: indexPath)

        // Configure the cell...
        let variants = comicBookCollection.variantSignifiers(issueNumber: currentIssueNumber, seriesTitle: currentSeriesTitle, publisherName: currentPublisherName)
        cell.textLabel?.text = "#\(currentIssueNumber!)"
        cell.detailTextLabel?.text = "variant \(variants[indexPath.row])"


        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let variants = comicBookCollection.variantSignifiers(issueNumber: currentIssueNumber, seriesTitle: currentSeriesTitle, publisherName: currentPublisherName)
//        let selectedVariant = variants[indexPath.row]
//        performSegue(withIdentifier: "EditComicBookSegue", sender: selectedVariant)
//    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditComicBookSegue" {
            let destination = segue.destination as! EditComicBookViewController
            
            destination.comicBookCollection = comicBookCollection
            
            if let selectedIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                let variants = comicBookCollection.variantSignifiers(issueNumber: currentIssueNumber, seriesTitle: currentSeriesTitle, publisherName: currentPublisherName)

                destination.currentIdentifier = "\(currentPublisherName!) \(currentSeriesTitle!) \(currentIssueNumber!)\(variants[selectedIndexPath.row])"
            }
        }
    }
}