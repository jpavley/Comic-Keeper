//
//  ComicBookCollection+Data.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/9/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public extension ComicBookCollection {
    
    class func createComicBookCollection() -> ComicBookCollection {
        
        let cbc = ComicBookCollection()
        
        // Batman
        
        let cb1 = createComicBook("DC Comics", "Batman", "1950", "100", "1234", "a", 10.20, Date(), 11.95, Date(), "vg")
        let cb2 = createComicBook("DC Comics", "Batman", "1950", "101", "1235", "b", 13.21, Date(), 16.85, Date(), "g")
        let cb3 = createComicBook("DC Comics", "Batman", "1950", "102", "1236", "a", 1.21, Date(), 15.05, Date(), "f")
        
        // Superman
        
        let cb4 = createComicBook("DC Comics", "Superman", "1970", "1", "3456", "x", 2.31, Date(), 15.05, Date(), "vg")
        let cb5 = createComicBook("DC Comics", "Superman", "1970", "3", "3457", "xx", 4.61, Date(), 19.05, Date(), "f")
        let cb6 = createComicBook("DC Comics", "Superman", "1970", "5", "3459", "xxx", 6.71, Date(), 20.05, Date(), "g")
        let cb7 = createComicBook("DC Comics", "Superman", "1970", "8", "3461", "xxx", 0.71, Date(), 20.05, Date(), "p")
        
        // Wonder Woman
        
        let cb8 = createComicBook("DC Comics", "Wonder Woman", "1980", "500", "1500", "w", 2.31, Date(), 15.05, Date(), "vg")
        let cb9 = createComicBook("DC Comics", "Wonder Woman", "1980", "502", "1502", "q", 2.31, Date(), 15.05, Date(), "vg")
        let cb10 = createComicBook("DC Comics", "Wonder Woman", "1980", "511", "1511", "w", 2.31, Date(), 15.05, Date(), "vg")
        
        // Aliens
        
        let cb11 = createComicBook("Dark Horse", "Aliens", "1990", "1", "1", "a", 2.31, Date(), 15.05, Date(), "vg")
        let cb12 = createComicBook("Dark Horse", "Aliens", "1990", "2", "2", "b", 2.31, Date(), 15.05, Date(), "g")
        
        // The Mask
        
        let cb13 = createComicBook("Dark Horse", "The Mask", "1995", "10", "10", "q", 2.31, Date(), 15.05, Date(), "vg")
        let cb14 = createComicBook("Dark Horse", "The Mask", "1995", "20", "20", "a", 2.31, Date(), 15.05, Date(), "g")
        let cb15 = createComicBook("Dark Horse", "The Mask", "1995", "34", "34", "n", 2.31, Date(), 15.05, Date(), "vg")
        
        // Preditor
        
        let cb16 = createComicBook("Dark Horse", "Preditor", "1985", "10", "10", "q", 2.31, Date(), 15.05, Date(), "vg")
        let cb17 = createComicBook("Dark Horse", "Preditor", "1985", "20", "20", "a", 2.31, Date(), 15.05, Date(), "g")
        
        // Preditor
        
        let cb18 = createComicBook("Dark Horse", "Terminator", "1999", "1", "1", "m", 2.31, Date(), 15.05, Date(), "vg")
        
        // Fantastic Four
        
        let cb19 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "1", "1", "a", 2.31, Date(), 15.05, Date(), "vg")
        let cb20 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "2", "2", "b", 2.31, Date(), 15.05, Date(), "vg")
        let cb21 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "3", "3", "c", 2.31, Date(), 15.05, Date(), "g")
        let cb22 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "4", "4", "d", 2.31, Date(), 15.05, Date(), "vg")
        let cb23 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "5", "5", "e", 2.31, Date(), 15.05, Date(), "g")
        
        // Fantastic Four
        
        let cb24 = createComicBook("Marvel Comics", "Hulk", "1962", "1", "1", "a", 2.31, Date(), 15.05, Date(), "vg")
        let cb25 = createComicBook("Marvel Comics", "Hulk", "1962", "3", "3", "a", 2.31, Date(), 15.05, Date(), "vg")
        let cb26 = createComicBook("Marvel Comics", "Hulk", "1962", "4", "5", "a", 2.31, Date(), 15.05, Date(), "vg")
        let cb27 = createComicBook("Marvel Comics", "Hulk", "1962", "10", "10", "a", 2.31, Date(), 15.05, Date(), "f")
        
        // Iron Man
        
        let cb28 = createComicBook("Marvel Comics", "Iron Man", "1963", "1", "1", "a", 2.31, Date(), 15.05, Date(), "p")
        let cb29 = createComicBook("Marvel Comics", "Iron Man", "1963", "18", "18", "a", 2.31, Date(), 15.05, Date(), "p")
        let cb30 = createComicBook("Marvel Comics", "Iron Man", "1963", "19", "19", "a", 2.31, Date(), 15.05, Date(), "p")
        
        // Thor
        
        let cb31 = createComicBook("Marvel Comics", "The Mighty Thor", "1964", "7", "7", "a", 2.31, Date(), 15.05, Date(), "f")
        let cb32 = createComicBook("Marvel Comics", "The Mighty Thor", "1964", "8", "8", "a", 2.31, Date(), 15.05, Date(), "f")
        
        // X-men
        
        let cb33 = createComicBook("Marvel Comics", "X-men", "1968", "101", "101", "x", 2.31, Date(), 15.05, Date(), "vf")
        
        
        cbc.comicbooks = [cb1,cb2,cb3,cb4,cb5,cb6,cb7,cb8,cb9,cb10,cb11,cb12,cb13,cb14,cb15,cb16,
                          cb17,cb18,cb19,cb20,cb21,cb22,cb23,cb24,cb25,cb26,cb27,cb28,cb29,cb30,
                          cb31,cb32,cb33]
        
        return cbc
    }
    
    class func createComicBook(_ publisher: String,
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

    
}
