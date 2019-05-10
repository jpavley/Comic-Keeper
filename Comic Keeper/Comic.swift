//
//  Comic.swift
//  Comic Keeper
//
//  Created by John Pavley on 5/7/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation

public class Comic {
    
    public var publisher: String
    public var series: String
    public var era: String
    public var issueNumber: String
    public var legacyIssueNumber: String
    public var variant: String
    
    init(publisher: String,
         series: String,
         era: String,
         issueNumber: String,
         legacyIssueNumber: String,
         variant: String) {
        
        self.publisher = publisher
        self.series = series
        self.era = era
        self.issueNumber = issueNumber
        self.legacyIssueNumber = legacyIssueNumber
        self.variant = variant
    }
}
