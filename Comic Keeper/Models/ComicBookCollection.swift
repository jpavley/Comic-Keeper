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
    
    public var collectedPublisherNames: [String] {
        let publisherNames = comicBooks.map {$0.comic.publisher}
        let listB = [String]()
        return createFilteredNameListFrom(listA: publisherNames, listB: listB)
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
    
    /// List of series titles (series name + era) for a publisher in this collection.
    /// - No duplicates!
    ///
    /// - Parameter publisherName: unique name of the publisher
    /// - Returns: list of series unique names (name + era)
    public func seriesTitlesFor(publisherName: String) -> [String] {
        let seriesTitles = comicBooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesTitle : nil}
        var filteredNames = [String]()
        seriesTitles.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames
    }
    
    public func seriesNamesFor( publisherName: String) -> [String] {
        let seriesNames = comicBooks.compactMap {$0.comic.publisher == publisherName ? $0.seriesName : nil}
        var filteredNames = [String]()
        seriesNames.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames
    }
        
    /// List of issue numbers for a series in this collection.
    /// - *Why are issue numbers strings?* Publishers are creative in numbering and might create
    ///   "issue numbers" that include non-numeric characters.
    /// - No duplicates!
    ///
    /// - Parameters:
    ///   - publisherName: unique name of the publisher
    ///   - seriesTitle: series title (name + era)
    /// - Returns: list of issues numbers as list of strings
    public func issuesNumbersFor(publisherName: String, seriesTitle: String) -> [String] {
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
    
    public func variantSignifiersFor(publisherName: String, seriesTitle: String, issueNumber: String) -> [String] {
        let variants = comicBooks.compactMap {
            $0.comic.publisher == publisherName && $0.seriesTitle == seriesTitle && $0.comic.issueNumber == issueNumber ? $0.comic.variant : nil
        }
        return variants
    }
    
    /// Get a comic book by navigation hierarchy components.
    ///
    /// - Parameters:
    ///   - publisherName: top level navigation hierarchy component.
    ///   - seriesName: navigation hierarchy component.
    ///   - era: navigation hierarchy component.
    ///   - issueNumber: navigation hierarchy component.
    ///   - variantSignifier: bottom level navigation hierarchy component.
    /// - Returns: all the comicbooks found with this navigation hierachy identifier or nothing.
    public func comicBookFrom(publisherName: String,
                              seriesName: String,
                              era: String,
                              issueNumber: String,
                              variantSignifier: String) -> [ComicBook]? {
        
        let identifier = "\(publisherName) \(seriesName) \(era) \(issueNumber)\(variantSignifier)"
        return comicBookFrom(identifier: identifier)
    }
    
    /// Get a comic book by navigation hierarchy identifier
    public func comicBookFrom(identifier: String) -> [ComicBook]? {
        let identifiedComicBooks = comicBooks.filter { $0.identifier == identifier }
        return identifiedComicBooks
    }
    
    /// Get a comic book by globally unique ID
    ///
    /// - UUIDs change with every run of an app.
    /// - Don't use UUIDs between sessions unless you manually persist and assign them
    public func comicBookFrom(guid: UUID) -> ComicBook? {
        let comicBook = comicBooks.filter { $0.guid == guid }
        return comicBook.first
    }
    
    public func createEmptyComicBook() -> ComicBook? {
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
        return self.comicBookFrom(guid: guid) != nil
    }
    
    public func deleteComicBook(with guid: UUID) {
        let updatedComicBooks = self.comicBooks.filter { $0.guid != guid }
        self.comicBooks = updatedComicBooks
        self.comicBooks.sort()
    }
}
