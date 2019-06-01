//
//  ComicBookDM+CoreDataProperties.swift
//  
//
//  Created by John Pavley on 6/1/19.
//
//

import Foundation
import CoreData


extension ComicBookDM {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComicBookDM> {
        return NSFetchRequest<ComicBookDM>(entityName: "ComicBookDM")
    }

    @NSManaged public var purchasePrice: Decimal?
    @NSManaged public var purchaseDate: Date?
    @NSManaged public var sellPrice: Decimal?
    @NSManaged public var sellDate: Date?
    @NSManaged public var photoID: Int32?
    @NSManaged public var condition: String
    @NSManaged public var publisher: String
    @NSManaged public var series: String
    @NSManaged public var issueNumber: String
    @NSManaged public var legacyIssueNumber: String
    @NSManaged public var variant: String

}
