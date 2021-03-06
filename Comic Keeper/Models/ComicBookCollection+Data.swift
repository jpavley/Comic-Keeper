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
        
        let cb1 = createComicBook("DC Comics", "Batman", "1950", "100", "1234", "a", nil, nil, nil, nil, "Very Good")
        let cb2 = createComicBook("DC Comics", "Batman", "1950", "101", "1235", "b", 13.21, Date(), nil, nil, "Good")
        let cb3 = createComicBook("DC Comics", "Batman", "1950", "102", "1236", "a", nil, nil, 15.05, Date(), "Very Fine")
        
        // Wonder Woman 1970
        
        let cb4 = createComicBook("DC Comics", "Wonder Woman", "1970", "1", "3456", "x", nil, Date(), nil, Date(), "Very Good")
        let cb5 = createComicBook("DC Comics", "Wonder Woman", "1970", "3", "3457", "xx", 4.61, nil, 19.05, nil, "Fine")
        let cb6 = createComicBook("DC Comics", "Wonder Woman", "1970", "5", "3459", "xxx", 6.71, nil, 20.05, nil, "Good")
        let cb7 = createComicBook("DC Comics", "Wonder Woman", "1970", "8", "3461", "xxx", nil, Date(), nil, Date(), "Very Poor")
        let cb4a = createComicBook("DC Comics", "Wonder Woman", "1970", "1", "3456", "a", nil, nil, nil, nil, "Very Good")
        let cb5a = createComicBook("DC Comics", "Wonder Woman", "1970", "3", "3457", "a", nil, nil, nil, nil, "Fine")
        let cb6a = createComicBook("DC Comics", "Wonder Woman", "1970", "5", "3459", "a", nil, nil, nil, nil, "Good")
        let cb7a = createComicBook("DC Comics", "Wonder Woman", "1970", "8", "3461", "a", nil, nil, nil, nil, "Poor")
        let cb4b = createComicBook("DC Comics", "Wonder Woman", "1970", "1", "3456", "b", nil, nil, nil, nil, "Very Good")
        let cb5b = createComicBook("DC Comics", "Wonder Woman", "1970", "3", "3457", "b", nil, nil, nil, nil, "Very Fine")
        let cb6b = createComicBook("DC Comics", "Wonder Woman", "1970", "5", "3459", "b", nil, nil, nil, nil, "Good")
        let cb7b = createComicBook("DC Comics", "Wonder Woman", "1970", "8", "3461", "b", nil, nil, nil, nil, "Poor")

        // Wonder Woman 1980
        
        let cb8 = createComicBook("DC Comics", "Wonder Woman", "1980", "1", "1500", "a", nil, nil, 15.05, Date(), "Very Good")
        let cb9 = createComicBook("DC Comics", "Wonder Woman", "1980", "1", "1502", "b", nil, nil, 15.05, Date(), "Perfect")
        let cb10 = createComicBook("DC Comics", "Wonder Woman", "1980", "1", "1511", "x", 2.31, nil, nil, Date(), "Very Good")
        
        // Aliens
        
        let cb11 = createComicBook("Dark Horse", "Alien", "1990", "1", "", "a", 2.22, nil, 3.33, Date(), "Very Good")
        let cb12 = createComicBook("Dark Horse", "Alien", "1990", "2", "", "b", 3.33, Date(), 15.05, Date(), "Good")
        
        // The Mask 1995
        
        let cb13 = createComicBook("Dark Horse", "The Mask", "1995", "10", "", "q", nil, nil, nil, nil, "Very Good")
        let cb14 = createComicBook("Dark Horse", "The Mask", "1995", "20", "", "a", nil, nil, nil, nil, "Good")
        let cb15 = createComicBook("Dark Horse", "The Mask", "1995", "34", "", "n", nil, nil, nil, nil, "Very Fine")
        
        // Terminator
        
        let cb18 = createComicBook("Dark Horse", "Terminator", "1999", "1", "", "m", 2.31, Date(), 15.05, Date(), "Very Good")
        
        // The Mask 1985
        
        let cb16 = createComicBook("Dark Horse", "The Mask", "1985", "10", "", "q", 2.31, Date(), 15.05, Date(), "Very Good")
        let cb17 = createComicBook("Dark Horse", "The Mask", "1985", "20", "", "a", nil, nil, nil, nil, "Good")
        let cb16a = createComicBook("Dark Horse", "The Mask", "1985", "10", "", "n", 2.31, Date(), 15.05, Date(), "Very Good")
        let cb17a = createComicBook("Dark Horse", "The Mask", "1985", "20", "20", "o", nil, nil, nil, nil, "Good")

        // Fantastic Four 1961
        
        let cb19 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "1", "", "a", 2.31, Date(), 15.05, Date(), "Very Good")
        let cb20 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "2", "", "b", nil, nil, nil, nil, "Very Good")
        let cb21 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "3", "", "c", nil, nil, nil, nil, "Good")
        let cb22 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "4", "", "d", nil, nil, nil, nil, "Very Good")
        let cb23 = createComicBook("Marvel Comics", "Fantastic Four", "1961", "5", "", "e", 2.31, Date(), 15.05, Date(), "Good")
        
        // Fantastic Four
        
        let cb24 = createComicBook("Marvel Comics", "Hulk", "1962", "1", "", "a", nil, nil, nil, nil, "Very Good")
        let cb25 = createComicBook("Marvel Comics", "Hulk", "1962", "3", "", "b", nil, nil, nil, nil, "Very Good")
        let cb26 = createComicBook("Marvel Comics", "Hulk", "1962", "4", "", "c", nil, nil, nil, nil, "Very Good")
        let cb27 = createComicBook("Marvel Comics", "Hulk", "1962", "10", "", "d", 2.31, Date(), 15.05, Date(), "Fine")
        
        // Iron Man
        
        let cb28 = createComicBook("Marvel Comics", "Iron Man", "1963", "1", "", "a", 2.31, Date(), 15.05, Date(), "Poor")
        let cb29 = createComicBook("Marvel Comics", "Iron Man", "1963", "18", "", "a", nil, nil, nil, nil, "Poor")
        let cb30 = createComicBook("Marvel Comics", "Iron Man", "1963", "19", "", "a", 2.31, Date(), 15.05, Date(), "Poor")
        let cb28a = createComicBook("Marvel Comics", "Iron Man", "1963", "1", "", "b", nil, nil, nil, nil, "Poor")
        let cb29b = createComicBook("Marvel Comics", "Iron Man", "1963", "18", "", "c", 2.31, Date(), 15.05, Date(), "Poor")
        let cb30c = createComicBook("Marvel Comics", "Iron Man", "1963", "19", "", "x", 2.31, Date(), 15.05, Date(), "Poor")

        // Thor
        
        let cb31 = createComicBook("Marvel Comics", "The Mighty Thor", "1964", "7", "700", "a", 2.31, Date(), 15.05, Date(), "Fine")
        let cb32 = createComicBook("Marvel Comics", "The Mighty Thor", "1964", "8", "800", "a", 2.21, Date(), 15.55, Date(), "Fine")
        
        // Fantastic Four 1968
        
        let cb33 = createComicBook("Marvel Comics", "Fantastic Four", "1968", "101", "101", "x", nil, nil, nil, nil, "Very Good")
        
        
        cbc.comicBooks = [cb11, cb12, cb13, cb14, cb15, cb16, cb17, cb18, cb19, cb20, cb21, cb22, cb23, cb24, cb25, cb26, cb27, cb28, cb29, cb30, cb31, cb32, cb33, cb4, cb5, cb6, cb7, cb8, cb9, cb10, cb2, cb1, cb3, cb4a, cb5a, cb6a, cb7a, cb4b, cb5b, cb6b, cb7b, cb16a, cb17a, cb28a, cb29b, cb30c]
        
        cbc.comicBooks = cbc.comicBooks.sorted()
        
        return cbc
    }
    
    class func createComicBook(_ publisher: String,
                               _ series: String,
                               _ era: String,
                               _ issueNumber: String,
                               _ legacyIssueNumber: String,
                               _ variant: String,
                               _ purchasePrice: Decimal?,
                               _ purchaseDate: Date?,
                               _ sellPrice: Decimal?,
                               _ sellDate: Date?,
                               _ condition: String) -> ComicBook {
        
        let c1 = Comic(publisher: publisher, series: series, era: era, issueNumber: issueNumber, legacyIssueNumber: legacyIssueNumber, variant: variant)
        
        let b1 = Book(condition: condition, purchasePrice: purchasePrice, purchaseDate: purchaseDate, sellPrice: sellPrice, sellDate: sellDate, photoID: nil)
        
        return ComicBook(comic: c1, book: b1)
    }

    
}
