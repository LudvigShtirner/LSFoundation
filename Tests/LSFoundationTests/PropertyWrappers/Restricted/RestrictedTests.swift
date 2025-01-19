//
//  RestrictedTests.swift
//
//
//  Created by Алексей Филиппов on 17.07.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class RestrictedTests: XCTestCase {
    // MARK: - Tests
    func testThatInitialValueInsideBounds() {
        // Given
        // When
        @Restricted(range: 0 ... 100) var wrapper = 103
        @Restricted(range: 20 ... 80) var example = 11
        // Then
        XCTAssertEqual(wrapper, 100)
        XCTAssertEqual(example, 20)
    }
    
    func testThatValueInsideBoundsAfterChange() {
        // Given
        @Restricted(range: 20 ... 80) var example = 87
        // When
        example = 0
        // Then
        XCTAssertEqual(example, 20)
    }
    
    func testThatValueDoesNotChangeWhenInBounds() {
        // Given
        @Restricted(range: 20 ... 80) var example = 87
        // When
        example = 35
        // Then
        XCTAssertEqual(example, 35)
    }
}
