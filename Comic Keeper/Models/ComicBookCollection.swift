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
    
    init() {
        comicbooks = [ComicBook]()
    }
    
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
        return ["Batman", "Fantastic Four", "Spider Man", "Super Man", "Wonder Woman", "X-Men"].sorted()
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
        
        for i in 1...9999 {
            result.append("\(i)")
        }
        
        return result
    }
    
    public var allPossibleConditions: [String] {
        return ["Very Poor", "Poor", "Good", "Very Good", "Fine", "Very Fine", "Perfect"]
    }
        
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
    
    public func variantSignifiers(issueNumber: String, seriesTitle: String, publisherName: String) -> [String] {
        let variants = comicbooks.compactMap {
            $0.comic.publisher == publisherName && $0.seriesTitle == seriesTitle && $0.comic.issueNumber == issueNumber ? $0.comic.variant : nil
        }
        return variants
    }
    
    // MARK:- ComicBook CRUD (Create, Read, Update, Delete)
    
    // MARK:- Get Functions
    
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
    
    /// Get a comic book by navigation hierarchy identifier
    public func comicBook(from identifier: String) -> ComicBook? {
        let comicBook = comicbooks.filter { $0.identifier == identifier }
        return comicBook.first
    }
    
    /// Get a comic book by globally unique ID
    public func comicBook(from guid: UUID) -> ComicBook? {
        let comicBook = comicbooks.filter { $0.guid == guid }
        return comicBook.first
    }
    
    // MARK:- Create Functions
    
    public func createComicBook() -> ComicBook? {
        // TODO: create a empty comic book
        return nil
    }
    
    public func createComicBook(publisherName: String, seriesName: String, era: String, issueNumber: String) -> ComicBook? {
        // TODO: create a comic book for a specific location in the navigation hierachy to the issue number level
        return nil
    }
    
    public func createComicBook(publisherName: String, seriesName: String, era: String) -> ComicBook? {
        // TODO: create a comic book for a specific location in the navigation hierachy to the ear level
        return nil
    }
    
    // MARK:- Delete Functions
    
    public func duplicationComicBook(with identifier: String) -> ComicBook? {
        // TODO: duplicate the specified comic book
        return nil
    }
    
    public func duplicationComicBook(with guid: UUID) -> ComicBook? {
        // TODO: duplicate the specified comic book
        return nil
    }
    
    // MARK:- Duplicate Functions
    
    public func deleteComicBook(with identifier: String) {
        // TODO: delete the specified comic book
    }
    
    public func deleteComicBook(with guid: UUID) {
        // TODO: delete the specified comic book
    }
    
}
