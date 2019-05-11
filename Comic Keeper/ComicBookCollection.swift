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
    
    func seriesTitle(for comic: Comic) -> String {
        return "\(comic.series) \(comic.era)"
    }
    
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
    
    func issuesNumbers(seriesName: String, publisherName: String) -> [String] {
        let issueNumbers = comicbooks.compactMap {
            $0.comic.publisher == publisherName && seriesTitle(for: $0.comic) == seriesName ? $0.comic.issueNumber : nil
        }
        return issueNumbers
    }

    func comicBooks(for publisher: String) -> [ComicBook] {
        return [ComicBook]()
    }
}
