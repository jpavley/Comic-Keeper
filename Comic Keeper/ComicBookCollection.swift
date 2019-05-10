//
//  ComicBookCollection.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class ComicBookCollection {
    
    var comicbooks: [ComicBook]
    
    init() {
        comicbooks = [ComicBook]()
    }
    
    var publisherNames: [String] {
        return [String]()
    }
    
    func seriesNames(for publisher: String) -> [String] {
        return [String]()
    }
    
    func comicBooks(for publisher: String) -> [ComicBook] {
        return [ComicBook]()
    }
    
    func issueCount(for comicBookSeries: String) -> Int {
        return 0
    }
}
