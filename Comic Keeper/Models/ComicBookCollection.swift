//
//  ComicBookCollection.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class ComicBookCollection {
    
    public var comicbooks: [ComicBook]
    public static let emptyComicIdentifier = ""
    
    init() {
        comicbooks = [ComicBook]()
    }
    
    // TODO: Merge publisherNames with starterPublisherNames
    
    /// The names of all the publishers in this collection.
    /// - No duplicates!
    public var publisherNames: [String] {
        let publisherNames = comicbooks.map {$0.comic.publisher}
        var filteredNames = [String]()
        
        // early return if we have no actual publishers
        if publisherNames.isEmpty || publisherNames[0] == "" {
            return filteredNames
        }
        
        publisherNames.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        
        return filteredNames.sorted()
    }
    
    public var starterPublisherNames: [String] {
        return ["Dark Horse", "DC Comics", "Marvel Comics", "Image Comics", "IDW Publishing", "Valiant Comics",].sorted()
    }
    
    // TODO: Merge seriesNames with starterSeriesNames
    
    public var seriesNames: [String] {
        let seriesNames = comicbooks.map {$0.comic.series}
        var filteredNames = [String]()
        
        // early return if we have no actual publishers
        if seriesNames.isEmpty || seriesNames[0] == "" {
            return filteredNames
        }
        
        seriesNames.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames.sorted()
    }
    
    public var starterSeriesNames: [String] {
        return ["Concrete", "Bacchus", "Alien", "Predator","Aliens vs. Predator", "Terminator", "The Mask", "Nexus", "Grendel", "Hellboy", "Batman", "Fantastic Four", "Hulk", "Iron Man", "The Mighty Thor", "Wonder Woman", "The Amazing Spider-Man", "The X-Men", "Captain Ameria", "The Silver Surfer", "Daredevil", "Batman", "Superman", "The Green Lantern", "Wonder Woman", "Green Arrow"].sorted()
    }
    
    // TODO: Probably need to separate user created eras and all possible eras
    
    public var eras: [String] {
        
        var result = [" "]
        let now = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: now)
        
        for year in 1900...currentYear {
            result.append("\(year)")
        }
        
        return result
    }
    
    public var allPossibleIssueNumbers: [String] {
        var result = [" "]
        
        for i in 0...9999 {
            result.append("\(i)")
        }
        
        return result
    }
    
    // TODO: allPossibleConditions should be starterConditions
    // TODO: Merge starterConditions with user added conditions
    // TODO: First condition should be " " to signify no condition noted
    
    public var allPossibleConditions: [String] {
        return ["Very Poor", "Poor", "Good", "Very Good", "Fine", "Very Fine", "Perfect"]
    }
    
    // TODO: seriesTitles(for:) is too vauge, change to seriesTitlesFor(publisher:)
    // TODO: The fact that series titles is a list of seriesNames + eras is not obvious. Make it obvious
    // TODO: Maybe get rind of seriesTitles as its easy to get name and era and concatenate!
        
    /// List of series titles for a publisher in this collection.
    /// - No duplicates!
    ///
    /// - Parameter publisherName: unique name of the publisher
    /// - Returns: list of series unique names (name + era)
    public func seriesTitles(for publisherName: String) -> [String] {
        let seriesTitles = comicbooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesTitle : nil}
        var filteredNames = [String]()
        seriesTitles.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames
    }
    
    // TODO: seriesNames(for:) is too vauge, change to seriesNamesFor(publisher:)
    
    public func seriesNames(for publisherName: String) -> [String] {
        let seriesNames = comicbooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesName : nil}
        var filteredNames = [String]()
        seriesNames.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames
    }
    
    // TODO: Change issuesNumbers(seriesTitle:publisherName:) to issuesNumbersFor(publisherName:seriesTitle:)
    // TODO: Should it be issuesNumbersFor(publisher:series:era) ?

        
    /// List of issue numbers for a series in this collection.
    /// - *Why are issue numbers strings?* Publishers are creative in numbering and might create
    ///   "issue numbers" that include non-numeric characters.
    /// - No duplicates!
    ///
    /// - Parameters:
    ///   - seriesName: series title (name + era)
    ///   - publisherName: unique name of the publisher
    /// - Returns: list of issues numbers as list of strings
    public func issuesNumbers(seriesTitle: String, publisherName: String) -> [String] {
        let issueNumbers = comicbooks.compactMap {
            $0.comic.publisher == publisherName && $0.seriesTitle == seriesTitle ? $0.comic.issueNumber : nil
        }
        var filteredNumbers = [String]()
        issueNumbers.forEach { name in
            if !filteredNumbers.contains(name) {
                filteredNumbers.append(name)
            }
        }
        
        filteredNumbers = filteredNumbers.sorted() {$0.localizedStandardCompare($1) == .orderedAscending}
        
        return filteredNumbers
    }
    
    // TODO: Change variantSignifiers(issueNumber:seriesTitle:publisherName:) to issuesNumbersFor(publisherName:seriesTitle:issueNumber)
    // TODO: Should it be variantSignifiers(publisher:series:era:issueNUmber) ?

    public func variantSignifiers(issueNumber: String, seriesTitle: String, publisherName: String) -> [String] {
        let variants = comicbooks.compactMap {
            $0.comic.publisher == publisherName && $0.seriesTitle == seriesTitle && $0.comic.issueNumber == issueNumber ? $0.comic.variant : nil
        }
        return variants
    }
    
    // MARK:- ComicBook CRUD (Create, Read, Update, Delete)
    
    // MARK:- Get Functions
    
    // TODO: Probably should return an array of comic books
    // TODO: comicBook(publisherName:seriesName:era:issueNumber:variantSignifier:) is too vague! Should be getComicBookFrom(publisherName:seriesName:era:issueNumber:variantSignifier:)
    
    /// Get a comic book by navigation hierarchy components.
    ///
    /// - Parameters:
    ///   - publisherName: top level navigation hierarchy component.
    ///   - seriesName: navigation hierarchy component.
    ///   - era: navigation hierarchy component.
    ///   - issueNumber: navigation hierarchy component.
    ///   - variantSignifier: bottom level navigation hierarchy component.
    /// - Returns: the frist comicbook found with this navigation hierachy identifier or nothing.
    public func comicBook(publisherName: String, seriesName: String, era: String, issueNumber: String, variantSignifier: String) -> ComicBook? {
        let identifier = "\(publisherName) \(seriesName) \(era) \(issueNumber)\(variantSignifier)"
        return comicBook(from: identifier)
    }
    
    // TODO: Probably should return an array of comic books
    // TODO: comicBook(from:) is too vague! Should be getComicBookFrom(identifier:)
    
    /// Get a comic book by navigation hierarchy identifier
    public func comicBook(from identifier: String) -> ComicBook? {
        let comicBook = comicbooks.filter { $0.identifier == identifier }
        return comicBook.first
    }
    
    // TODO: Probably should return an array of comic books
    // TODO: comicBook(from:) is too vague! Should be getComicBookFrom(guid:)
    
    /// Get a comic book by globally unique ID
    ///
    /// - UUIDs change with every run of an app.
    /// - Don't use UUIDs between sessions unless you manually persist and assign them
    public func comicBook(from guid: UUID) -> ComicBook? {
        let comicBook = comicbooks.filter { $0.guid == guid }
        return comicBook.first
    }
    
    // TODO: Rename createEmptyComicBook()
    
    public func createComicBook() -> ComicBook? {
        let comic = Comic(publisher: "", series: "", era: "", issueNumber: "", legacyIssueNumber: "", variant: "")
        let book = Book(condition: "", purchasePrice: 0, purchaseDate: nil, sellPrice: 0, sellDate: nil, photoID: nil)
        let comicBook = ComicBook(comic: comic, book: book)
        return comicBook
    }
    
    public func addComicBook(newComicBook: ComicBook) {
        self.comicbooks.append(newComicBook)
        self.comicbooks.sort()
    }
    
    public func comicBookExists(guid: UUID) -> Bool {
        return self.comicBook(from: guid) != nil
    }
    
    public func deleteComicBook(with guid: UUID) {
        let updatedComicBooks = self.comicbooks.filter { $0.guid != guid }
        self.comicbooks = updatedComicBooks
        self.comicbooks.sort()
    }
    
}
