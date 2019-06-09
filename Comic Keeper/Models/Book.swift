//
//  Book.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class Book {
    
    public var purchasePrice: Decimal?
    public var purchaseDate: Date?
    public var sellPrice: Decimal?
    public var sellDate: Date?
    public var photoID: Int?
    public var condition: String
    
    
    init(condition: String,
         purchasePrice: Decimal?,
         purchaseDate: Date?,
         sellPrice: Decimal?,
         sellDate: Date?,
         photoID: Int?) {
        
        self.purchasePrice = purchasePrice
        self.purchaseDate = purchaseDate
        self.sellPrice = sellPrice
        self.sellDate = sellDate
        self.photoID = photoID
        self.condition = condition
    }
    
    // MARK:- Date Text
    
    public func dateText(from date: Date!) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        var result = "none"
        if let d = date {
            result = formatter.string(from: d)
        }
        return result

    }
    
    public class func textDate(from text: String) -> Date? {
        var result: Date?
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        result = dateFormatter.date(from: text)

        return result
    }
    
    public var purchaseDateText: String {
        return dateText(from: purchaseDate)
    }
    
    public var sellDateText: String {
        return dateText(from: sellDate)
    }
    
    // MARK:- Price Text
    
    func priceText(from price: Decimal!) -> String {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        
        if let p = price {
            return formatter.string(for: p)!
        } else {
            return "none"
        }

    }
    
    public var purchasePriceText: String {
        return priceText(from: purchasePrice)
    }
    
    public var sellPriceText: String {
        return priceText(from: sellPrice)
    }

}
