//
//  rgalleryUITests.swift
//  rgalleryUITests
//
//  Created by gquatt on 10/06/2020.
//  Copyright © 2020 gquattromani. All rights reserved.
//

import XCTest

class rgalleryUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testIfWeHaveASearchBarInTheFirstScreen() {
        let app = XCUIApplication()
        app.launch()
        let searchBar = app.tabBars["MainSearchBar"]
        XCTAssertNotNil(searchBar)
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
