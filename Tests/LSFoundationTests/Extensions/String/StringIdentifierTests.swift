//
//  StringIdentifierTests.swift
//
//
//  Created by Алексей Филиппов on 15.07.2024.
//

// Apple
import XCTest

class StringIdentifierTests: XCTestCase {
    // MARK: - Tests
    func testIdentifiersisUnique() {
        // Given
        // When
        let string1 = String.uniqueIdentifier
        let string2 = String.uniqueIdentifier
        let string3 = String.uniqueIdentifier
        let string4 = String.uniqueIdentifier
        let string5 = String.uniqueIdentifier
        // Then
        let set = Set([string1, string2, string3, string4, string5])
        XCTAssertEqual(set.count, 5)
    }
}
