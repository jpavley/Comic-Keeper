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
    let dummyDataStartPublisherCount = 6
    let dummyDataLastStarterPublishername = "Valiant Comics"
    
    let dummyDataSeriesCount = 9
    let dummyDataFirstSeriesName = "Aliens"
    let dummyDataStartSeriesCount = 26
    let dummyDataLastStarterSeriesname = "Wonder Woman"


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
        XCTAssertEqual(cbcUT.starterPublisherNames.count, dummyDataStartPublisherCount)
        XCTAssertEqual(cbcUT.starterPublisherNames[dummyDataStartPublisherCount - 1], dummyDataLastStarterPublishername)
    }
    
    func testSeriesNames() {
        print(cbcUT.seriesNames)
        XCTAssertEqual(cbcUT.seriesNames.count, dummyDataSeriesCount)
        XCTAssertEqual(cbcUT.seriesNames.first!, dummyDataFirstSeriesName)
    }

    func testStarterSeriesNames() {
        print(cbcUT.starterSeriesNames)
        XCTAssertEqual(cbcUT.starterSeriesNames.count, dummyDataStartSeriesCount)
        XCTAssertEqual(cbcUT.starterSeriesNames[dummyDataStartSeriesCount - 1], dummyDataLastStarterSeriesname)
    }

}
