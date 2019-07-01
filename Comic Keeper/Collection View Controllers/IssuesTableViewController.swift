//
//  IssuesTableViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit
import CoreData

class IssuesTableViewController: UITableViewController {
    
    var comicBookCollection: ComicBookCollection!
    var currentPublisherName: String!
    var currentSeriesTitle: String!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = currentSeriesTitle
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let issues = comicBookCollection.issuesNumbersFor(publisherName: currentPublisherName, seriesTitle: currentSeriesTitle)
        return issues.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let issues = comicBookCollection.issuesNumbersFor(publisherName: currentPublisherName, seriesTitle: currentSeriesTitle)
        let currentIssueNumber = issues[section]
        let variants = comicBookCollection.variantSignifiersFor(publisherName: currentPublisherName,
                                                                seriesTitle: currentSeriesTitle,
                                                                issueNumber: currentIssueNumber)
        return variants.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let issues = comicBookCollection.issuesNumbersFor(publisherName: currentPublisherName, seriesTitle: currentSeriesTitle)
        return "Issue #\(issues[section])"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get data for the cell
        let issues = comicBookCollection.issuesNumbersFor(publisherName: currentPublisherName, seriesTitle: currentSeriesTitle)
        let currentIssueNumber = issues[indexPath.section]
        let variants = comicBookCollection.variantSignifiersFor(publisherName: currentPublisherName,
                                                                seriesTitle: currentSeriesTitle,
                                                                issueNumber: currentIssueNumber)
        let currentVariant = variants[indexPath.row]
        let currentIssue = issues[indexPath.section]
        
        // update the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "IssuesCell", for: indexPath)
        cell.textLabel?.text = "#\(currentIssue) variant \(currentVariant)"
        return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditComicBookSegue" {
            
            let destination = segue.destination as! EditComicBookViewController
            destination.comicBookCollection = comicBookCollection
            destination.managedObjectContext = managedObjectContext
            
            if let selectedIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                
                let issues = comicBookCollection.issuesNumbersFor(publisherName: currentPublisherName, seriesTitle: currentSeriesTitle)
                
                let currentIssueNumber = issues[selectedIndexPath.section]

                let variants = comicBookCollection.variantSignifiersFor(publisherName: currentPublisherName,
                                                                        seriesTitle: currentSeriesTitle,
                                                                        issueNumber: currentIssueNumber)
                
                let variant = variants[selectedIndexPath.row]
                
                destination.currentIdentifier = "\(currentPublisherName!) \(currentSeriesTitle!) \(currentIssueNumber)\(variant)"
            }
        } else {
            print(segue.identifier!)
        }
    }
}
