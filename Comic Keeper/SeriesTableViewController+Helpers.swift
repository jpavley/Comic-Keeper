//
//  SeriesTableViewController+Helpers.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import UIKit

extension SeriesTableViewController {
    
    // MARK:- Dummy Data
    
    var dummyDataPublishers: [String] {
        return ["DC Comics", "Dark Horse Comics", "Marvel Comics"]
    }
    var dummyDataDCSeries: [String] {
        return ["Batman", "Superman", "Wonder Woman"]
    }
    var dummyDataDHSeries: [String] {
        return ["Aliens", "Mask", "Prediter", "Terminator"]
    }
    var dummyDataMarvelSeries: [String] {
        return ["Fanstic Four","Hulk", "Iron Man","Thor", "X-Men"]
    }
    
    func series(for section: Int) -> [String]? {
        
        switch section {
        case 0:
            return dummyDataDCSeries
        case 1:
            return dummyDataDHSeries
        case 2:
            return dummyDataMarvelSeries
        default:
            return nil
        }
    }
    
    func issueCount(for indexPath: IndexPath) -> Int {
        return indexPath.section + indexPath.row
    }
}
