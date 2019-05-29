//
//  SeriesTableViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

class SeriesTableViewController: UITableViewController {
    
    var comicBookCollection: ComicBookCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        title = "Comicbooks"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return comicBookCollection.publisherNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return comicBookCollection.publisherNames[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let publisherName = comicBookCollection.publisherNames[section]
        let seriesTitles = comicBookCollection.seriesTitles(for: publisherName)
        return seriesTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            
            if let selectedIndexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                let publisherName = comicBookCollection.publisherNames[selectedIndexPath.section]
                let seriesTitles = comicBookCollection.seriesTitles(for: publisherName)
                destination.currentPublisherName = publisherName
                destination.currentSeriesTitle = seriesTitles[selectedIndexPath.row]
            }
        }
    }
}
