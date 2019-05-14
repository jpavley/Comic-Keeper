//
//  ComicBook.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class ComicBook {
    
    public var comic: Comic
    public var book: Book
    
    public var publisherName: String {
        return comic.publisher
    }
    
    public var seriesName: String {
        return comic.series
    }
    
    public var seriesEra: String {
        return comic.era
    }
    
    public var seriesTitle: String {
        return "\(comic.series) \(comic.era)"
    }
    
    public var identifier: String {
        return "\(publisherName) \(seriesName) \(seriesEra) \(comic.issueNumber)\(comic.variant)"
    }
    
    init(comic: Comic, book: Book) {
        
        self.comic = comic
        self.book = book
    }
}

// Note this extention can't be in a seperate file because protocol implementations can not be
// public so the seperate file has default access.

extension ComicBook: Comparable {
    
    public static func < (lhs: ComicBook, rhs: ComicBook) -> Bool {
        return lhs.identifier < rhs.identifier
    }
    
    public static func == (lhs: ComicBook, rhs: ComicBook) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
