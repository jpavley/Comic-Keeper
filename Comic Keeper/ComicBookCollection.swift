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
    var publisherNames: [String] {
        let publisherNames = comicbooks.map {$0.comic.publisher}
        var filteredNames = [String]()
        publisherNames.forEach { name in
            if !filteredNames.contains(name) {
                filteredNames.append(name)
            }
        }
        return filteredNames
    }
    
    /// The full title of series (name + era).
    /// - Series are rebooted and restart from issue #1.
    /// - Publishers unreliably use legacy numbering and volume numbering.
    ///
    /// - Parameter comic: object that contains series and era info
    /// - Returns: series name + era
    func seriesTitle(for comic: Comic) -> String {
        return "\(comic.series) \(comic.era)"
    }
    
    /// List of series titles for a publisher in this collection.
    /// - No duplicates!
    ///
    /// - Parameter publisherName: unique name of the publisher
    /// - Returns: list of series unique names (name + era)
    func seriesNames(for publisherName: String) -> [String] {
        let seriesNames = comicbooks.compactMap {$0.comic.publisher == publisherName ? seriesTitle(for: $0.comic) : nil}
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
    ///
    /// - Parameters:
    ///   - seriesName: series title (name + era)
    ///   - publisherName: unique name of the publisher
    /// - Returns: list of issues numbers as list of strings
    func issuesNumbers(seriesName: String, publisherName: String) -> [String] {
        let issueNumbers = comicbooks.compactMap {
            $0.comic.publisher == publisherName && seriesTitle(for: $0.comic) == seriesName ? $0.comic.issueNumber : nil
        }
        return issueNumbers
    }
}
