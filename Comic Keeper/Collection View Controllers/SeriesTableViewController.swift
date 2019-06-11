//
//  SeriesTableViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit
import CoreData

class SeriesTableViewController: UITableViewController {
    
    var comicBookCollection: ComicBookCollection!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
//        navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.setHidesBackButton(true, animated: true)
        
        title = "Comicbooks"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if comicBookCollection.publisherNames.count == 0 {
            return 1
        } else {
            return comicBookCollection.publisherNames.count

        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if comicBookCollection.publisherNames.isEmpty {
            return "Collection Empty"
        } else {
            return comicBookCollection.publisherNames[section]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if comicBookCollection.publisherNames.isEmpty {
            return 1
        } else {
            let publisherName = comicBookCollection.publisherNames[section]
            let seriesTitles = comicBookCollection.seriesTitles(for: publisherName)
            return seriesTitles.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if comicBookCollection.publisherNames.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCollectionCell", for: indexPath)

            cell.textLabel?.text = "Touch + to add a comic book!"
            cell.detailTextLabel?.text = ""
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesCell", for: indexPath)
            
            // Configure the cell...
            let publisherName = comicBookCollection.publisherNames[indexPath.section]
            let seriesTitles = comicBookCollection.seriesTitles(for: publisherName)
            let seriesTitle = seriesTitles[indexPath.row]
            let issueNumbers = comicBookCollection.issuesNumbers(seriesTitle: seriesTitle, publisherName: publisherName)
            
            cell.textLabel?.text = seriesTitle
            cell.detailTextLabel?.text = "\(issueNumbers.count) issues"
            return cell
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SeriesSegue" {
            let destination = segue.destination as! IssuesTableViewController
            destination.comicBookCollection = comicBookCollection
            destination.managedObjectContext = managedObjectContext
            
            if let selectedIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                let publisherName = comicBookCollection.publisherNames[selectedIndexPath.section]
                let seriesTitles = comicBookCollection.seriesTitles(for: publisherName)
                destination.currentPublisherName = publisherName
                destination.currentSeriesTitle = seriesTitles[selectedIndexPath.row]
            }
        }
    }
}
