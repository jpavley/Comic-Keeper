//
//  EditComicBookView+Segues.swift
//  Comic Keeper
//
//  Created by John Pavley on 6/14/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

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

extension EditComicBookViewController {
    
    // MARK:- Show Segues
    
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
            controller.viewID = viewID
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
                        
        default:
            break
            //fatalError("unsupported seque in EditComicBookViewController")
        }
    }
    
    // MARK:- Unwind Segues
    
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
            let viewID = controller.viewID else {
                fatalError("controller.pickerTitle is nil")
        }
        
        guard
            let newText = controller.selectedItemName else {
                fatalError("controller.newItemTextField.text is nil")
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

}
