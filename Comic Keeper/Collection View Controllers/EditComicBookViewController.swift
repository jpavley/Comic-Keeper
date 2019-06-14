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
    let emptyComicIdentifier = "  "
    
    // MARK:- Actions
    
    
    @IBAction func saveAction(_ sender: Any) {
        performSegue(withIdentifier: "BrokenNavigationSegue", sender: self)
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
        
        if comicBookCollection.comicbooks.isEmpty {
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
        comicBookCollection.comicbooks = [cb1]
        currentIdentifier = emptyComicIdentifier
        comicBookUnderEdit = comicBookCollection.comicbooks[0]
        
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
        comicBookUnderEdit = comicBookCollection.comicBook(from: currentIdentifier)
        
        guard let currentComicBook = comicBookUnderEdit else {
            fatalError("no ComicBook \(currentIdentifier!) to edit")
        }
        
        title = "#\(currentComicBook.comic.issueNumber )\(currentComicBook.comic.variant )"
        
        publisherLabel.text = currentComicBook.publisherName
        eraLabel.text = currentComicBook.seriesEra
        seriesLabel.text = currentComicBook.seriesName
        issueNumberLabel.text = currentComicBook.comic.issueNumber
        
        if currentComicBook.comic.legacyIssueNumber.isEmpty {
            legacyIssueNumberLabel.text = "none"
        } else {
            legacyIssueNumberLabel.text = currentComicBook.comic.legacyIssueNumber
        }
        
        variantLabel.text = currentComicBook.comic.variant
        
        conditionLabel.text = currentComicBook.book.condition
        purchasePriceLabel.text = currentComicBook.book.purchasePriceText != "none" ? "$\(currentComicBook.book.purchasePriceText)" : "none"
        purchaseDateLabel.text = currentComicBook.book.purchaseDateText
        sellPriceLabel.text = currentComicBook.book.sellDateText != "none" ? "$\(currentComicBook.book.sellPriceText)" : "none"
        sellDateLabel.text = currentComicBook.book.sellDateText
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
