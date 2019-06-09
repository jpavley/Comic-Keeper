//
//  Transaction.swift
//  Comic Keeper
//
//  Created by John Pavley on 6/1/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

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

enum TransactionChange: String {
    
    /// No properties were changed
    case nochange = "No Change"
    
    /// Navigation hierarchy invalid, needs to re-calculated because the identity of an object has changed
    case navigationBreakingChange = "Braking Change"
    
    /// Data property only, no need to re-calculate the nav hierachy
    case dataPropertyChange = "Property Change"
}


/// Stores infomation about user edits for use in determinating what, if anything, has changed.
struct Transaction: CustomStringConvertible {
    
    var description: String {
        return "viewID: {\(viewID)}, in: {\(inputValue)}, out: {\(outputValue)}, change: {\(transactionChange)}"
    }
    
    var viewID: ViewIdentifer
    var inputValue: String
    var outputValue: String
    var transactionChange: TransactionChange = .nochange
    
    func commit(currentComicBook: ComicBook) {
        
        switch viewID {
            
        case .publisher:
            currentComicBook.comic.publisher = outputValue

            
        case .series:
            currentComicBook.comic.series = outputValue

        case .era:
            currentComicBook.comic.era = outputValue

        case .issueNumber:
            currentComicBook.comic.issueNumber = outputValue

        case .legacyNumber:
            currentComicBook.comic.legacyIssueNumber = outputValue

        case .condition:
            currentComicBook.book.condition = outputValue

        case .variantInfo:
            currentComicBook.comic.variant = outputValue

        case .purchasePrice:
            currentComicBook.book.purchasePrice = 0 // TODO: transform String into Decimal
       case .salesPrice:
        currentComicBook.book.sellPrice = 0 // TODO: transform String into Decimal

        case .purchaseDate:
            currentComicBook.book.purchaseDate = Book.textDate(from: outputValue)!

        case .salesDate:
            currentComicBook.book.sellDate = Book.textDate(from: outputValue)!

        case .photo:
            currentComicBook.book.photoID = 0 // TODO: transform String into Int
            
        case .noView:
            fatalError("Transact.Commit() encoundered noView case")
        }

    }
}
