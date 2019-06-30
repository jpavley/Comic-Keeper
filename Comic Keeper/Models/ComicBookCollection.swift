//
//  ComicBookCollection.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class ComicBookCollection {
    
    public var comicBooks: [ComicBook]
    public static let emptyComicIdentifier = ""
    
    init() {
        comicBooks = [ComicBook]()
    }
    
    
    /// Creates a single list by combining listA and listB and filtering out duplicate strings.
    ///
    /// - Parameters:
    ///   - listA: an array of strings
    ///   - listB: another array of strings
    /// - Returns: a sorted array of strings, empty if listA and listB are empty or start with an empty string.
    private func createFilteredNameListFrom(listA: [String], listB: [String]) -> [String] {
        let combinedList = listA + listB
        var filteredList = [String]()
        
        // early return if we have no actual items
        if combinedList.isEmpty || combinedList[0] == "" {
            return filteredList
        }
        
        combinedList.forEach { s in
            if !filteredList.contains(s) {
                filteredList.append(s)
            }
        }
        
        return filteredList.sorted()
    }
    
    /// The names of all the publishers in this collection (including all the starter publisher names.
    /// - No duplicates!
    /// - Sorted!
    public var publisherNames: [String] {
        let publisherNames = comicBooks.map {$0.comic.publisher}
        return createFilteredNameListFrom(listA: publisherNames, listB:starterPublisherNames)
    }
    
    /// A list of common publisher names.
    public var starterPublisherNames: [String] {
        return ["Dark Horse", "DC Comics", "Marvel Comics", "Image Comics", "IDW Publishing", "Valiant Comics",].sorted()
    }
    
    /// The names of all the series in this collection (including all the starter series names.
    /// - No duplicates!
    /// - Sorted!
    public var seriesNames: [String] {
        let seriesNames = comicBooks.map {$0.comic.series}
        return createFilteredNameListFrom(listA: seriesNames, listB: starterSeriesNames)
    }
    
    /// A list of common series names.
    public var starterSeriesNames: [String] {
        return ["Concrete", "Bacchus", "Alien", "Predator","Aliens vs. Predator", "Terminator", "The Mask", "Nexus", "Grendel", "Hellboy", "Batman", "Fantastic Four", "Hulk", "Iron Man", "The Mighty Thor", "Wonder Woman", "The Amazing Spider-Man", "The X-Men", "Captain Ameria", "The Silver Surfer", "Daredevil", "Batman", "Superman", "The Green Lantern", "Wonder Woman", "Green Arrow"].sorted()
    }
    
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
    
    public var conditions: [String] {
        let conditionNames = comicBooks.map {$0.book.condition}
        return createFilteredNameListFrom(listA: conditionNames, listB: standardConditions)
    }
    
    public var standardConditions: [String] {
        return ["Very Poor", "Poor", "Good", "Very Good", "Fine", "Very Fine", "Perfect", "Unknown"]
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
        let seriesTitles = comicBooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesTitle : nil}
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
        let seriesNames = comicBooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesName : nil}
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
        let issueNumbers = comicBooks.compactMap {
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
        let variants = comicBooks.compactMap {
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
        let comicBook = comicBooks.filter { $0.identifier == identifier }
        return comicBook.first
    }
    
    // TODO: Probably should return an array of comic books
    // TODO: comicBook(from:) is too vague! Should be getComicBookFrom(guid:)
    
    /// Get a comic book by globally unique ID
    ///
    /// - UUIDs change with every run of an app.
    /// - Don't use UUIDs between sessions unless you manually persist and assign them
    public func comicBook(from guid: UUID) -> ComicBook? {
        let comicBook = comicBooks.filter { $0.guid == guid }
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
        self.comicBooks.append(newComicBook)
        self.comicBooks.sort()
    }
    
    public func comicBookExists(guid: UUID) -> Bool {
        return self.comicBook(from: guid) != nil
    }
    
    public func deleteComicBook(with guid: UUID) {
        let updatedComicBooks = self.comicBooks.filter { $0.guid != guid }
        self.comicBooks = updatedComicBooks
        self.comicBooks.sort()
    }
    
}
