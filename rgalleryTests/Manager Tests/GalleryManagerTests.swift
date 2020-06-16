//
//  rgalleryTests.swift
//  rgalleryTests
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import XCTest
@testable import rgallery

class GalleryManagerTests: XCTestCase {
    var httpClient: HttpClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testPrepareData(){
        let manager = GalleryManager()
        
        let galleryDataInput = GalleryDataRoot(kind: "Listing", data: DataGallery(children: [Child(kind: "t3", data: DataChild(title: "Title", subreddit: "mockSR", thumbnail: "http://link.com/image.jpg"))]))
        
        let preparedData = manager.prepareData(for: galleryDataInput)
        
        XCTAssertEqual(preparedData[0].title, "Title", "title should be the same")
        XCTAssertEqual(preparedData[0].url, "http://link.com/image.jpg", "thumbnail url should be the same")
        XCTAssertEqual(preparedData[0].subreddit, "mockSR", "subreddit should be the same")
    }
    
    func testParseJSON(){
        let manager = GalleryManager()
        
        let dataInput = Data("""
        {
          "kind": "Listing",
          "data": {
            "children": [
              {
                "kind": "t3",
                "data": {
                  "subreddit": "House",
                  "title": "VIP- SUBJOI..thank me later",
                  "thumbnail": "https://b.thumbs.redditmedia.com/JpzWwCgWAaYMFWzzchxzjHFQgavMvgd3tNnkqYrP1sk.jpg"
                }
              }
            ]
          }
        }
        """.utf8)
        
        let parsedGalleryModel = manager.parseJSON(dataInput)
        
        XCTAssertEqual(parsedGalleryModel?.thumbs[0].title, "VIP- SUBJOI..thank me later", "title should be the same")
        XCTAssertEqual(parsedGalleryModel?.thumbs[0].url, "https://b.thumbs.redditmedia.com/JpzWwCgWAaYMFWzzchxzjHFQgavMvgd3tNnkqYrP1sk.jpg", "thumbnail url should be the same")
        XCTAssertEqual(parsedGalleryModel?.thumbs[0].subreddit, "House", "subreddit should be the same")
    }
    
    func testPerformRequestWithURL() {
        let url = URL(string: "https://www.reddit.com/r/house/top.json")
        
        httpClient.get(url: url!) { (success, response) in
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func testPerformRequestResumeIsCalled() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        let url = URL(string: "https://www.reddit.com/r/house/top.json")
        
        httpClient.get(url: url!) { (success, response) in
        }
        
        XCTAssert(dataTask.resumeWasCalled, "task.resume() was called")
    }
    
    func testPerformRequestDataIsNotNil() {
        let dataInput = Data("""
        {
          "kind": "Listing",
          "data": {
            "children": [
              {
                "kind": "t3",
                "data": {
                  "subreddit": "House",
                  "title": "VIP- SUBJOI..thank me later",
                  "thumbnail": "https://b.thumbs.redditmedia.com/JpzWwCgWAaYMFWzzchxzjHFQgavMvgd3tNnkqYrP1sk.jpg"
                }
              }
            ]
          }
        }
        """.utf8)
        
        session.nextData = dataInput
        
        let expectation = XCTestExpectation(description: "NO")
        
        httpClient.get(url: URL(string: "https://www.reddit.com/r/house/top.json")!) { (data, error) in
            XCTAssertEqual(data, dataInput)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

}
