//
//  EditComicBookViewController.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/12/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit
import CoreData

enum ViewIdentifer: String {
    case publisher = "Publisher"
    case series = "Series"
    case era = "Era"
    case issueNumber = "Issue Number"
    case legacyNumber = "Legacy Number"
    case condition = "Condition"
    case variantInfo = "Variant Info"
    case purchasePrice = "Purchase Price"
    case salesPrice = "Sales Price"
    case purchaseDate = "Purchase Date"
    case salesDate = "Sale Date"
    case photo = "Photo"
    case noView = "No View"
}

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
        // Touching save triggers the SaveNavEditsSegue segue which opens the SeriesTableViewController
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        guard let currentComicBook = comicBookUnderEdit else {
            fatalError("no ComicBook to edit")
        }
        
        func configureStandardPicker(viewID: ViewIdentifer, viewTitle: String, pickerList: [String], selectedItem: String, noneButtonVisible: Bool) {
            
            let picker = segue.destination as! StandardPicker
            picker.viewID = viewID
            picker.itemList = pickerList
            picker.pickerTitle = viewTitle
            picker.selectedItemName = selectedItem
            picker.hintText = currentComicBook.identifier
            picker.noneButtonVisible = noneButtonVisible
        }
        
        func configureAddPicker(viewID: ViewIdentifer, viewTitle: String, selectedItem: String) {
            let picker = segue.destination as! PickerAddViewController
            picker.pickerTitle = viewTitle
            picker.hintText = currentComicBook.identifier
            picker.selectedItemName = selectedItem
            picker.viewID = viewID
        }
        
        func configureDatePicker(viewID: ViewIdentifer, viewTitle: String, date: Date) {
            let controller = segue.destination as! PickerDateViewController
            controller.pickerTitle = viewTitle
            controller.hintText = currentComicBook.identifier
            controller.selectedItemDate = date
        }
        
        func calculatePickerListAndSelectedItem(existingNames: [String], starterNames: [String], selectedName: String) -> (pickerList: [String], selectedItem: String) {
            let pl: [String]
            let si: String
            
            if existingNames.isEmpty {
                pl = starterNames
                si = ""
            } else {
                pl = existingNames.sorted()
                si = selectedName
            }
            
            return (pickerList: pl, selectedItem: si)
        }
        
        switch segue.identifier {
        
        // Standard Picker Cases
        
        case "ChoosePublisherSegue":
            navigationBroken = true
            let plsi = calculatePickerListAndSelectedItem(existingNames: comicBookCollection.publisherNames, starterNames: comicBookCollection.starterPublisherNames, selectedName: currentComicBook.comic.publisher)
            configureStandardPicker(viewID: .publisher, viewTitle: "Publisher", pickerList: plsi.pickerList, selectedItem: plsi.selectedItem, noneButtonVisible: false)
            
        case "ChooseSeriesSegue":
            navigationBroken = true
            let plsi = calculatePickerListAndSelectedItem(existingNames: comicBookCollection.seriesNames, starterNames: comicBookCollection.starterSeriesNames, selectedName: currentComicBook.comic.series)
            configureStandardPicker(viewID: .series, viewTitle: "Series", pickerList: plsi.pickerList, selectedItem: plsi.selectedItem, noneButtonVisible: false)
            
        case "ChooseEraSegue":
            navigationBroken = true
            let pl = comicBookCollection.eras
            let si = currentComicBook.seriesEra
            configureStandardPicker(viewID: .era, viewTitle: "Era", pickerList: pl, selectedItem: si, noneButtonVisible: false)
            
        case "ChooseIssueNumber":
            navigationBroken = true
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook.comic.issueNumber
            configureStandardPicker(viewID: .issueNumber, viewTitle: "Issue Number", pickerList: pl, selectedItem: si, noneButtonVisible: false)

            
        case "ChooseLegacyIssueNumber":
            let pl = comicBookCollection.allPossibleIssueNumbers
            let si = currentComicBook.comic.legacyIssueNumber
            configureStandardPicker(viewID: .legacyNumber, viewTitle: "Legacy Issue Number", pickerList: pl, selectedItem: si, noneButtonVisible: true)
            
        case "ChooseConditionSegue":
            let pl = comicBookCollection.allPossibleConditions
            let si = currentComicBook.book.condition
            
            configureStandardPicker(viewID: .condition, viewTitle: "Condition", pickerList: pl, selectedItem: si, noneButtonVisible: false)
            
        // Picker Add Cases
        
        case "EditVariantSignifierSegue":
            navigationBroken = true
            let v = currentComicBook.comic.variant // never nil
            configureAddPicker(viewID: .variantInfo, viewTitle: "Variant Info", selectedItem: v)
            
        case "EditPurchasePriceSegue":
            let p = currentComicBook.book.purchasePriceText // never nil
            configureAddPicker(viewID: .purchasePrice, viewTitle: "Purchase Price", selectedItem: p)

        case "EditSalesPriceSegue":
            let p = currentComicBook.book.sellPriceText // never nil
            configureAddPicker(viewID: .salesPrice, viewTitle: "Sales Price", selectedItem: p)

        // Picker Date Cases
        
        case "EditPurchaseDateSegue":
            let purchaseDate = currentComicBook.book.purchaseDate ?? Date()
            configureDatePicker(viewID: .purchaseDate, viewTitle: "Purchase Date", date: purchaseDate)
            
        case "EditSalesDateSegue":
            let sellDate = currentComicBook.book.sellDate ?? Date()
            configureDatePicker(viewID: .salesDate, viewTitle: "Sales Date", date: sellDate)
        
        case "SaveNavEditsSegue":
            let destination = segue.destination as! SeriesTableViewController
            destination.comicBookCollection = comicBookCollection
            break

        default:
            fatalError("unsupported seque in EditComicBookViewController")
        }
    }
        
    // Unwind/exit segue from AddItemViewController
    @IBAction func addItemDidEditItem(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! PickerAddViewController
        
        guard
            let rawText = controller.newItemTextField.text,
            let viewID = controller.viewID else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        let newText = rawText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch viewID {
            
        case .variantInfo:
            variantLabel.text = newText
            comicBookUnderEdit?.comic.variant = newText
            
        case .purchasePrice:
            purchasePriceLabel.text = newText
            comicBookUnderEdit?.book.purchasePrice = transformTextIntoDecimal(newText: newText)
            
        case .salesPrice:
            sellPriceLabel.text = newText
            comicBookUnderEdit?.book.sellPrice = transformTextIntoDecimal(newText: newText)

        case .publisher:
            publisherLabel.text = newText
            comicBookUnderEdit?.comic.publisher = newText

        case .series:
            seriesLabel.text = newText
            comicBookUnderEdit?.comic.series = newText
            
        case .condition:
            conditionLabel.text = newText
            comicBookUnderEdit?.book.condition = newText

        default:
            fatalError("unexpected case: \(viewID)")
        }
    }
    
    // Unwind/exit segue from list picker to edit comic book view controller.
    @IBAction func listPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerTableViewController
        
        guard
            let newText = controller.selectedItemName,
            let viewID = controller.viewID else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        switch viewID {
        case .publisher:
            publisherLabel.text = newText
            comicBookUnderEdit?.comic.publisher = newText
            
        case .series:
            seriesLabel.text = newText
            comicBookUnderEdit?.comic.series = newText
        
        case .condition:
            conditionLabel.text = newText
            comicBookUnderEdit?.book.condition = newText

        default:
            fatalError("unexpected case: \(viewID)")
        }
    }
    
    // Unwind/exit segue from dial picker to edit comic book view controller.
    @IBAction func dialPickerDidPickItem(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerDialViewController
        
        guard
            let newText = controller.selectedItemName,
            let viewID = controller.viewID else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        switch viewID {
        case .era:
            eraLabel.text = newText
            comicBookUnderEdit?.comic.era = newText
            
        case .issueNumber:
            issueNumberLabel.text = newText
            comicBookUnderEdit?.comic.issueNumber = newText
            
        case .legacyNumber:
            legacyIssueNumberLabel.text = newText
            comicBookUnderEdit?.comic.legacyIssueNumber = newText
            
        default:
            fatalError("unexpected case: \(viewID)")
        }
    }
    
    // Unwind/exit segue from date picker to edit comic book view controller.
    @IBAction func datePickerDidPickDate(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! PickerDateViewController
        
        guard
            let newText = controller.selectedItemName,
            let viewID = controller.viewID else {
                fatalError("controller.newItemTextField.text and/or controller.pickerTitle is nil")
        }
        
        switch viewID {
        case .purchaseDate:
            purchaseDateLabel.text = newText
            comicBookUnderEdit?.book.purchaseDate = Book.textDate(from: newText)
            
        case .salesDate:
            sellDateLabel.text = newText
            comicBookUnderEdit?.book.sellDate = Book.textDate(from: newText)
            
        default:
            fatalError("unexpected case: \(viewID)")
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
