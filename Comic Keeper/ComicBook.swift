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
    
    init(comic: Comic, book: Book) {
        
        self.comic = comic
        self.book = book
    }
}
