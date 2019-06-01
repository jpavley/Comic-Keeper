//
//  CKTransaction.swift
//  Comic Keeper
//
//  Created by John Pavley on 6/1/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation


/// Stores infomation about user edits for use in determinating what, if anything, has changed
struct CKTransaction {
    
    var fieldName: String
    var inputValue: String
    var outputValue: String
    
    var fieldHasChanged: Bool {
        return inputValue == outputValue
    }
}
