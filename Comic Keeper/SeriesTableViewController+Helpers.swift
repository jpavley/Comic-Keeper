//
//  SeriesTableViewController+Helpers.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

extension SeriesTableViewController {
    
    // MARK:- Dummy Data
    
    var dummyDataPublishers: [String] {
        return ["DC Comics", "Dark Horse Comics", "Marvel Comics"]
    }
    
    var dummyDataDCSeries: [String] {
        return ["Batman", "Superman", "Wonder Woman"]
    }
    
    var dummyDataDHSeries: [String] {
        return ["Aliens", "Mask", "Prediter", "Terminator"]
    }
    
    var dummyDataMarvelSeries: [String] {
        return ["Fanstic Four","Hulk", "Iron Man","Thor", "X-Men"]
    }
    
    func createComicBookCollection() -> ComicBookCollection {
        
        let cbc = ComicBookCollection()
        
        let cb1 = createComicBook("DC Comics", "Batman", "1950", "100", "1234", "a", 10.20, Date(), 11.95, Date(), "vg")
        
        let cb2 = createComicBook("DC Comics", "Batman", "1950", "101", "1235", "b", 13.21, Date(), 16.85, Date(), "g")
        
        let cb3 = createComicBook("DC Comics", "Batman", "1950", "102", "1236", "a", 1.21, Date(), 15.05, Date(), "f")
        
        let cb4 = createComicBook("DC Comics", "Superman", "1970", "1", "3456", "a", 1.21, Date(), 15.05, Date(), "f")

        
        cbc.comicbooks = [cb1,cb2,cb3,cb4]
        
        return cbc
    }
    
    func createComicBook(_ publisher: String,
                         _ series: String,
                         _ era: String,
                         _ issueNumber: String,
                         _ legacyIssueNumber: String,
                         _ variant: String,
                         _ purchasePrice: Decimal,
                         _ purchaseDate: Date,
                         _ sellPrice: Decimal,
                         _ sellDate: Date,
                         _ condition: String) -> ComicBook {
        
        let c1 = Comic(publisher: publisher, series: series, era: era, issueNumber: issueNumber, legacyIssueNumber: legacyIssueNumber, variant: variant)
        
        let b1 = Book(purchasePrice: purchasePrice, purchaseDate: purchaseDate, sellPrice: sellPrice, sellDate: sellDate, condition: condition)
        
        return ComicBook(comic: c1, book: b1)
        
    }

    
    func series(for section: Int) -> [String]? {
        
        switch section {
        case 0:
            return dummyDataDCSeries
        case 1:
            return dummyDataDHSeries
        case 2:
            return dummyDataMarvelSeries
        default:
            return nil
        }
    }
    
    func issueCount(for indexPath: IndexPath) -> Int {
        return indexPath.section + indexPath.row
    }
}
