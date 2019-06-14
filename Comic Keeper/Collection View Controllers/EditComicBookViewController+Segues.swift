//
//  EditComicBookViewController+Segues.swift
//  Comic Keeper
//
//  Created by John Pavley on 6/13/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

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
            
            // save info about this transaction
            transactionInfo = Transaction(viewID: viewID, inputValue: selectedItem, outputValue: "", transactionChange: .nochange, action: nil)
        }
        
        func configureAddPicker(viewID: ViewIdentifer, viewTitle: String, selectedItem: String) {
            let picker = segue.destination as! PickerAddViewController
            picker.pickerTitle = viewTitle
            picker.hintText = currentComicBook.identifier
            picker.selectedItemName = selectedItem
            picker.viewID = viewID
            
            // save info about this transaction
            transactionInfo = Transaction(viewID: viewID, inputValue: selectedItem, outputValue: "", transactionChange: .nochange, action: nil)
        }
        
        func configureDatePicker(viewID: ViewIdentifer, viewTitle: String, date: Date) {
            let controller = segue.destination as! PickerDateViewController
            controller.pickerTitle = viewTitle
            controller.hintText = currentComicBook.identifier
            controller.selectedItemDate = date
            
            // save info about this transaction
            let selectedItemName = currentComicBook.book.dateText(from: date)
            transactionInfo = Transaction(viewID: viewID, inputValue: selectedItemName, outputValue: "", transactionChange: .nochange, action: nil)
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
            
            let plsi = calculatePickerListAndSelectedItem(existingNames: comicBookCollection.publisherNames, starterNames: comicBookCollection.starterPublisherNames, selectedName: currentComicBook.comic.publisher)
            configureStandardPicker(viewID: .publisher, viewTitle: "Publisher", pickerList: plsi.pickerList, selectedItem: plsi.selectedItem, noneButtonVisible: false)
            
        case "ChooseSeriesSegue":
            
            let plsi = calculatePickerListAndSelectedItem(existingNames: comicBookCollection.seriesNames, starterNames: comicBookCollection.starterSeriesNames, selectedName: currentComicBook.comic.series)
            configureStandardPicker(viewID: .series, viewTitle: "Series", pickerList: plsi.pickerList, selectedItem: plsi.selectedItem, noneButtonVisible: false)
            
        case "ChooseEraSegue":
            let pl = comicBookCollection.eras
            let si = currentComicBook.seriesEra
            configureStandardPicker(viewID: .era, viewTitle: "Era", pickerList: pl, selectedItem: si, noneButtonVisible: false)
            
        case "ChooseIssueNumber":
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
    
    // MARK:- Exit Segues

    
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
            self.comicBookUnderEdit?.comic.variant = newText
            
        case .purchasePrice:
            self.comicBookUnderEdit?.book.purchasePrice = self.transformTextIntoDecimal(newText: newText)
            
        case .salesPrice:
            self.comicBookUnderEdit?.book.sellPrice = self.transformTextIntoDecimal(newText: newText)
            
        case .publisher:
            if !newText.isEmpty {
                self.comicBookUnderEdit?.comic.publisher = newText
            }
            
        case .series:
            if !newText.isEmpty {
                self.comicBookUnderEdit?.comic.series = newText
            }
            
        case .condition:
            if !newText.isEmpty {
                self.comicBookUnderEdit?.book.condition = newText
            }
            
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
            self.comicBookUnderEdit?.comic.publisher = newText
            
        case .series:
            self.comicBookUnderEdit?.comic.series = newText
            
        case .condition:
            self.comicBookUnderEdit?.book.condition = newText
            
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
            self.comicBookUnderEdit?.comic.era = newText
            
        case .issueNumber:
            self.comicBookUnderEdit?.comic.issueNumber = newText
            
        case .legacyNumber:
            self.comicBookUnderEdit?.comic.legacyIssueNumber = newText
            
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
            self.comicBookUnderEdit?.book.purchaseDate = Book.textDate(from: newText)
            
        case .salesDate:
            self.comicBookUnderEdit?.book.sellDate = Book.textDate(from: newText)
            
        default:
            fatalError("unexpected case: \(viewID)")
        }
    }

}
