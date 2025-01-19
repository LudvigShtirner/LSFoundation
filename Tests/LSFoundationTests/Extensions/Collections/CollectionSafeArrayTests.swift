//
//  CollectionSafeArrayTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 11.05.2022.
//

// Apple
import XCTest

class CollectionSafeArrayTests: XCTestCase {
    // MARK: - Data
    private let array = ["Zero", "First", "Second", "Third", "Fourth", "Fifth", "Sixth"]
    // MARK: - Tests
    func testThatElementReturnedWhenInBounds() {
        // Given
        // When
        let result = array[safe: 4]
        // Then
        XCTAssertNotNil(result)
    }
    
    func testThatElementIsNotReturnedWhenOutOfBounds() {
        // Given
        // When
        let result = array[safe: 7]
        // Then
        XCTAssertNil(result)
    }
}
