//
//  todoTests.swift
//  todoTests
//
//  Created by Dave Stanton on 4/19/25.
//

import XCTest
@testable import todo

final class todoTests: XCTestCase {
    
    func testItemCreation() {
        // Simple test for Item creation
        let item = Item(title: "Test Task")
        
        // Verify properties
        XCTAssertEqual(item.title, "Test Task")
        XCTAssertFalse(item.isCompleted)
        XCTAssertNotNil(item.timestamp)
    }
    
    func testItemCompletionToggle() {
        // Create an item and toggle completion
        let item = Item(title: "Test Task")
        XCTAssertFalse(item.isCompleted)
        
        // Toggle completion
        item.isCompleted = true
        XCTAssertTrue(item.isCompleted)
    }
}