//
//  EditComicBookViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/12/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit
import CoreData

class EditComicBookViewController: UITableViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var eraLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var legacyIssueNumberLabel: UILabel!
    @IBOutlet weak var variantLabel: UILabel!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var purchasePriceLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    @IBOutlet weak var sellDateLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK:- Properties
    
    var comicBookCollection: ComicBookCollection!
    var currentIdentifier: String!
    var comicBookUnderEdit: ComicBook?
    var image: UIImage?
    var imageHeight: CGFloat = 260
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK:- State/Data Management
    
    /// Once the navigation is broken, its broken forever
    var navigationBroken: Bool!
    
    // MARK:- Constants
    
    let photoSection = 1
    let photoRow = 0
    
    // MARK:- Actions
    
    /// Manually executes unwind segue to series table view controller.
    @IBAction func saveAction(_ sender: Any) {
        performSegue(withIdentifier: "BrokenNavigationSegue", sender: self)
    }
    
    /// Duplicates this comic book in this series for this publisher.
    @IBAction func duplicateAction(_ sender: Any) {
    }
    
    /// Removes this comic book and its data from the local and remote data store
    @IBAction func deleteAction(_ sender: Any) {
    }
    
    /// Updates the remote data store with this comic book's edits
    @IBAction func synchronizeAction(_ sender: Any) {
    }
    
    // MARK:- View Controller
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial state
        navigationBroken = false
        updateUI()
        
        if comicBookCollection.comicBooks.isEmpty {
            loadDummyComicBook()
        } else {
            loadRealComicBooks()
        }
    }
    
    // MARK:- Table View Implementation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == photoSection && indexPath.row == photoRow {
            tableView.deselectRow(at: indexPath, animated: true)
            pickPhoto()
        }
    }
        
    // MARK:- Helpers
    
    private func loadDummyComicBook() {
        
        let cb1 = ComicBookCollection.createComicBook("", "", "", "", "", "", nil, nil, nil, nil, "")
        comicBookCollection.comicBooks = [cb1]
        currentIdentifier = ComicBookCollection.emptyComicIdentifier
        comicBookUnderEdit = comicBookCollection.comicBooks[0]
        
        title = "Add Comic Book"
        
        publisherLabel.text = ""
        eraLabel.text = ""
        seriesLabel.text = ""
        issueNumberLabel.text = ""
        legacyIssueNumberLabel.text = ""
        variantLabel.text = ""
        conditionLabel.text = ""
        purchasePriceLabel.text = ""
        purchaseDateLabel.text = ""
        sellPriceLabel.text = ""
        sellDateLabel.text = ""
    }
    
    private func loadRealComicBooks() {
        
        if let ci = currentIdentifier {
            if let foundComicBook = comicBookCollection.comicBookFrom(identifier: ci)?.first! {
                comicBookUnderEdit = foundComicBook
            } else {
                fatalError("can't find comicbook for identifier \(ci)")
            }
        } else {
            comicBookUnderEdit = comicBookCollection.createEmptyComicBook()
            currentIdentifier = ComicBookCollection.emptyComicIdentifier
        }
        
        if let comicBookUnderEdit = comicBookUnderEdit {
            title = "#\(comicBookUnderEdit.comic.issueNumber )\(comicBookUnderEdit.comic.variant )"
            
            publisherLabel.text = comicBookUnderEdit.publisherName
            eraLabel.text = comicBookUnderEdit.seriesEra
            seriesLabel.text = comicBookUnderEdit.seriesName
            issueNumberLabel.text = comicBookUnderEdit.comic.issueNumber
            
            if comicBookUnderEdit.comic.legacyIssueNumber.isEmpty {
                legacyIssueNumberLabel.text = "none"
            } else {
                legacyIssueNumberLabel.text = comicBookUnderEdit.comic.legacyIssueNumber
            }
            
            variantLabel.text = comicBookUnderEdit.comic.variant
            
            conditionLabel.text = comicBookUnderEdit.book.condition
            purchasePriceLabel.text = comicBookUnderEdit.book.purchasePriceText != "none" ? "$\(comicBookUnderEdit.book.purchasePriceText)" : "none"
            purchaseDateLabel.text = comicBookUnderEdit.book.purchaseDateText
            sellPriceLabel.text = comicBookUnderEdit.book.sellDateText != "none" ? "$\(comicBookUnderEdit.book.sellPriceText)" : "none"
            sellDateLabel.text = comicBookUnderEdit.book.sellDateText
        }
    }
    
    /// newText should be in the format 0,000.00
    func transformTextIntoDecimal(newText: String) -> Decimal {
        
        // remove from String: "$", ".", ","
        var amountWithPrefix = newText
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, newText.count), withTemplate: "")
        
        // divdie by 100 and make it a Decimal
        let double = (amountWithPrefix as NSString).doubleValue
        let number = Decimal(double / 100)
        return number
    }
    
    func updateUI() {
        
        if navigationBroken {
            saveButton.isEnabled = true
            navigationItem.setHidesBackButton(true, animated: true)
        } else {
            saveButton.isEnabled = false
            navigationItem.setHidesBackButton(false, animated: true)
        }
    }
}
