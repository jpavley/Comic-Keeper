//
//  Book.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

class Book {
    
    var purchasePrice: Decimal
    var purchaseDate: Date
    var sellPrice: Decimal
    var sellDate: Date
    var condition: String
    
    init(purchasePrice: Decimal,
         purchaseDate: Date,
         sellPrice: Decimal,
         sellDate: Date,
         condition: String) {
        
        self.purchasePrice = purchasePrice
        self.purchaseDate = purchaseDate
        self.sellPrice = sellPrice
        self.sellDate = sellDate
        self.condition = condition
    }
}
