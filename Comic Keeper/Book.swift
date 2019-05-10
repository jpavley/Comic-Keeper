//
//  Book.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class Book {
    
    public var purchasePrice: Decimal
    public var purchaseDate: Date
    public var sellPrice: Decimal
    public var sellDate: Date
    public var condition: String
    
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
