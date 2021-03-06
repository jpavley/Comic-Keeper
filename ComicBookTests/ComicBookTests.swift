//
//  ComicBookTests.swift
//  ComicBookTests
//
//  Created by John Pavley on 6/15/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import XCTest

class ComicBookTests: XCTestCase {
    
    var cbcUT: ComicBookCollection!
    
    let dummyDataComicBookCount = 46
    let dummyDataComicBookFirstIdentifier = "DC Comics Batman 1950 100a"
    
    let dummyDataPublisherCount = 6
    let dummyDataFirstPublisherName = "DC Comics"
    let dummyDataStarterPublisherCount = 6
    let dummyDataLastStarterPublisherName = "Valiant Comics"
    
    let dummyDataSeriesCount = 24
    let dummyDataFirstSeriesName = "Alien"
    let dummyDataStarterSeriesCount = 26
    let dummyDataLastStarterSeriesName = "Wonder Woman"
    
    let dummyDataErasCount = 121 // TODO: This will break after 2019
    let dummyDataFirstEra = " " // First era is looks like an empty string
    let dummyDataLastEra = "2019" // TODO: This will break after 2019
    
    let dummyDataNumbersCount = 10_001
    let dummyDataFirstNumber = " " // First issue number is looks like an empty string
    let dummyDataLastNumber = "9999"
    
    let dummyDataConditionsCount = 8
    let dummyDataFirstCondition = "Fine"
    let dummyDataLastCondition = "Very Poor"
    
    let dummyDataSeriesTitles = ["Batman 1950", "Wonder Woman 1970", "Wonder Woman 1980"]
    let dummyDataSeriesNames = ["Batman", "Wonder Woman"]
    let dummyDataIssueNumbers = ["100", "101", "102"]
    let dummyDataVariantSignifiers = ["a"]
    
    let dummyDataEra = "1950"
    var dummyDataGuid: UUID?
    
    let dummyDataCollectedPublisherNamesCount = 3
    let dummyDataCollectedPublisherLastname = "Marvel Comics"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cbcUT = ComicBookCollection.createComicBookCollection()
        let cb = cbcUT.comicBookFrom(identifier: dummyDataComicBookFirstIdentifier)!.first!
        dummyDataGuid = cb.guid
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cbcUT = nil
    }
    
    func testCreateComicBookCollection() {
        let localCbcUT = ComicBookCollection()
        XCTAssertNotNil(localCbcUT)
        XCTAssertTrue(localCbcUT.comicBooks.count == 0)
    }
    
    func testCreateComicBookCollectionWithData() {
        XCTAssertNotNil(cbcUT)
        XCTAssertEqual(cbcUT.comicBooks.count, dummyDataComicBookCount)
        XCTAssertEqual(cbcUT.comicBooks.first!.identifier, dummyDataComicBookFirstIdentifier)
    }
    
    func testPublisherNames() {
        print(cbcUT.publisherNames)
        XCTAssertEqual(cbcUT.publisherNames.count, dummyDataPublisherCount)
        XCTAssertEqual(cbcUT.publisherNames.first!, dummyDataFirstPublisherName)
    }
    
    func testStarterPublisherNames() {
        print(cbcUT.starterPublisherNames)
        XCTAssertEqual(cbcUT.starterPublisherNames.count, dummyDataStarterPublisherCount)
        XCTAssertEqual(cbcUT.starterPublisherNames[dummyDataStarterPublisherCount - 1], dummyDataLastStarterPublisherName)
    }
    
    func testSeriesNames() {
        print(cbcUT.seriesNames)
        XCTAssertEqual(cbcUT.seriesNames.count, dummyDataSeriesCount)
        XCTAssertEqual(cbcUT.seriesNames.first!, dummyDataFirstSeriesName)
    }

    func testStarterSeriesNames() {
        print(cbcUT.starterSeriesNames)
        XCTAssertEqual(cbcUT.starterSeriesNames.count, dummyDataStarterSeriesCount)
        XCTAssertEqual(cbcUT.starterSeriesNames[dummyDataStarterSeriesCount - 1], dummyDataLastStarterSeriesName)
    }
    
    func testEras() {
        XCTAssertEqual(cbcUT.eras.count, dummyDataErasCount)
        XCTAssertEqual(cbcUT.eras.first!, dummyDataFirstEra)
        XCTAssertEqual(cbcUT.eras.last!, dummyDataLastEra)
    }
    
    func testAllPossibleIssueNumbers() {
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.count, dummyDataNumbersCount)
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.first!, dummyDataFirstNumber)
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.last!, dummyDataLastNumber)
    }
    
    func testAllPossibleConditions() {
        print(cbcUT.conditions)
        XCTAssertEqual(cbcUT.conditions.count, dummyDataConditionsCount)
        XCTAssertEqual(cbcUT.conditions.first!, dummyDataFirstCondition)
        XCTAssertEqual(cbcUT.conditions.last!, dummyDataLastCondition)
    }
    
    func testSeriesTitlesForPublisher() {
        print(cbcUT.seriesTitlesFor(publisherName: dummyDataFirstPublisherName))
        XCTAssertEqual(cbcUT.seriesTitlesFor(publisherName: dummyDataFirstPublisherName), dummyDataSeriesTitles)
    }
    
    func testSeriesNamesForPublisher() {
        print(cbcUT.seriesNamesFor(publisherName: dummyDataFirstPublisherName))
        XCTAssertEqual(cbcUT.seriesNamesFor(publisherName: dummyDataFirstPublisherName), dummyDataSeriesNames)
    }
    
    func testIssuesNumbers() {
        print(cbcUT.issuesNumbersFor(publisherName: dummyDataFirstPublisherName, seriesTitle: dummyDataSeriesTitles.first!))
        XCTAssertEqual(cbcUT.issuesNumbersFor(publisherName: dummyDataFirstPublisherName, seriesTitle: dummyDataSeriesTitles.first!), dummyDataIssueNumbers)
    }
    
    func  testVariantSignifiers() {
        print(cbcUT.variantSignifiersFor(publisherName: dummyDataFirstPublisherName, seriesTitle: dummyDataSeriesTitles.first!, issueNumber: dummyDataIssueNumbers.first!))
        XCTAssertEqual(cbcUT.variantSignifiersFor(publisherName: dummyDataFirstPublisherName, seriesTitle: dummyDataSeriesTitles.first!, issueNumber: dummyDataIssueNumbers.first!), dummyDataVariantSignifiers)
    }
    
    func testGetComicBookByParameters() {
        let cbUT = cbcUT.comicBookFrom(publisherName: dummyDataFirstPublisherName, seriesName: dummyDataSeriesNames.first!, era: dummyDataEra, issueNumber: dummyDataIssueNumbers.first!, variantSignifier: dummyDataVariantSignifiers.first!)!.first!
        print(cbUT.identifier)
        XCTAssertEqual(cbUT.identifier, dummyDataComicBookFirstIdentifier)
    }
    
    func testGetComicBookByIdentifier() {
        let cb = cbcUT.comicBookFrom(identifier: dummyDataComicBookFirstIdentifier)!.first!
        print(cb.identifier)
        XCTAssertEqual(cb.identifier, dummyDataComicBookFirstIdentifier)
    }
    
    func testGetComicBookByGuid() {
        let cb = cbcUT.comicBookFrom(identifier: dummyDataComicBookFirstIdentifier)!.first!
        XCTAssertEqual(cb.guid, dummyDataGuid)
    }
    
    func testCreateComicBook() {
        // An empty comic book only has an guid value, all other properties are nil, 0, or ""
        let newComicBook = cbcUT.createEmptyComicBook()
        XCTAssertNotNil(newComicBook)
        XCTAssertEqual(newComicBook!.identifier, ComicBookCollection.emptyComicIdentifier)
        XCTAssertEqual(newComicBook!.publisherName, "")
        XCTAssertEqual(newComicBook!.seriesName, "")
        XCTAssertEqual(newComicBook!.seriesEra, "")
        XCTAssertEqual(newComicBook!.seriesTitle, " ")
        XCTAssertEqual(newComicBook!.book.condition, "")
        XCTAssertEqual(newComicBook!.book.purchasePrice, 0)
        XCTAssertEqual(newComicBook!.book.sellDate, nil)
        XCTAssertNotNil(newComicBook!.guid)
    }
    
    func testAddComicBook() {
        // create a new comic book
        if let newComicBook = cbcUT.createEmptyComicBook() {
            XCTAssertNotNil(newComicBook)
            
            // make sure the comic book doesn't already exist in the collection
            XCTAssertNil(cbcUT.comicBookFrom(guid: newComicBook.guid))
            
            // add the comic book and see if it exists in the collection
            cbcUT.addComicBook(newComicBook: newComicBook)
            XCTAssertNotNil(cbcUT.comicBookFrom(guid: newComicBook.guid))
        }
    }
    
    func testComicBookExists() {
        XCTAssertTrue(cbcUT.comicBookExists(guid: dummyDataGuid!))
    }
    
    func testDeleteComicBook() {
        XCTAssertTrue(cbcUT.comicBookExists(guid: dummyDataGuid!))
        cbcUT.deleteComicBook(with: dummyDataGuid!)
        XCTAssertFalse(cbcUT.comicBookExists(guid: dummyDataGuid!))
    }
    
    func testCollectedPublisherNames() {
        XCTAssertNotNil(cbcUT.collectedPublisherNames)
        print(cbcUT.collectedPublisherNames)
        XCTAssertEqual(cbcUT.collectedPublisherNames.count, dummyDataCollectedPublisherNamesCount)
        XCTAssertEqual(cbcUT.collectedPublisherNames[dummyDataCollectedPublisherNamesCount - 1], dummyDataCollectedPublisherLastname)
    }
    
}
