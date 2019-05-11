//
//  ComicBook+Comparable.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

extension ComicBook: Comparable {
    
    public static func < (lhs: ComicBook, rhs: ComicBook) -> Bool {
        return lhs.identifier < rhs.identifier
    }
    
    public static func == (lhs: ComicBook, rhs: ComicBook) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
