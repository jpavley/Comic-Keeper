//
//  Transaction.swift
//  Comic Keeper
//
//  Created by John Pavley on 6/1/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

enum TransactionChange: String {
    
    /// No properties were changed
    case nochange = "No Change"
    
    /// Navigation hierarchy invalid, needs to re-calculated because the identity of an object has changed
    case navigationBreakingChange = "Braking Change"
    
    /// Data property only, no need to re-calculate the nav hierachy
    case dataPropertyChange = "Property Change"
}


/// Stores infomation about user edits for use in determinating what, if anything, has changed.
struct Transaction: CustomStringConvertible {
    
    var description: String {
        return "field: {\(transactionID)}, in: {\(inputValue)}, out: {\(outputValue)}, change: {\(transactionChange)}"
    }
    
    var transactionID: String
    var inputValue: String
    var outputValue: String
    var transactionChange: TransactionChange = .nochange
    
    var valueChanged: Bool {
        return inputValue == outputValue
    }
}
