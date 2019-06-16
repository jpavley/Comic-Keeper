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
    
    let dummyDataPublisherCount = 3
    let dummyDataFirstPublisherName = "DC Comics"
    let dummyDataStarterPublisherCount = 6
    let dummyDataLastStarterPublisherName = "Valiant Comics"
    
    let dummyDataSeriesCount = 9
    let dummyDataFirstSeriesName = "Aliens"
    let dummyDataStarterSeriesCount = 26
    let dummyDataLastStarterSeriesName = "Wonder Woman"
    
    let dummyDataErasCount = 121 // This will break after 2019
    let dummyDataFirstEra = " " // First era is looks like an empty string
    let dummyDataLastEra = "2019" // This will break after 2019
    
    let dummyDataNumbersCount = 10_001
    let dummyDataFirstNumber = " " // First issue number is looks like an empty string
    let dummyDataLastNumber = "9999" // This will break after 2019


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cbcUT = ComicBookCollection.createComicBookCollection()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cbcUT = nil
    }
    
    func testCreateComicBookCollection() {
        let localCbcUT = ComicBookCollection()
        XCTAssertNotNil(localCbcUT)
        XCTAssertTrue(localCbcUT.comicbooks.count == 0)
    }
    
    func testCreateComicBookCollectionWithData() {
        XCTAssertNotNil(cbcUT)
        XCTAssertEqual(cbcUT.comicbooks.count, dummyDataComicBookCount)
        XCTAssertEqual(cbcUT.comicbooks.first!.identifier, dummyDataComicBookFirstIdentifier)
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
    
    func testaAllPossibleIssueNumbers() {
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.count, dummyDataNumbersCount)
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.first!, dummyDataFirstNumber)
        XCTAssertEqual(cbcUT.allPossibleIssueNumbers.last!, dummyDataLastNumber)
    }
    

}
