//
//  todoUITests.swift
//  todoUITests
//
//  Created by Dave Stanton on 4/19/25.
//

import XCTest

final class todoUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testAppLaunches() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Basic validation that the app launched
        XCTAssertTrue(app.exists)
    }
}