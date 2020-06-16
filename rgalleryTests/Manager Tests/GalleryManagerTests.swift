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

}
