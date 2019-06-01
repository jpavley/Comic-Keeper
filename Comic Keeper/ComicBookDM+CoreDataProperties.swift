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

    @NSManaged public var purchasePrice: NSDecimalNumber?
    @NSManaged public var purchaseDate: NSDate?
    @NSManaged public var sellPrice: NSDecimalNumber?
    @NSManaged public var sellDate: NSDate?
    @NSManaged public var photoID: Int32
    @NSManaged public var condition: String?
    @NSManaged public var publisher: String?
    @NSManaged public var series: String?
    @NSManaged public var issueNumber: String?
    @NSManaged public var legacyIssueNumber: String?
    @NSManaged public var variant: String?

}
