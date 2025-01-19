//
//  IdentifiableTests.swift
//  
//
//  Created by Алексей Филиппов on 11.11.2022.
//

// Apple
import XCTest
// SPM
@testable import LSFoundation

final class IdentifiableTests: XCTestCase {
    // MARK: - Tests
    func testThatIdentifiableReturnsClassName() {
        // Given
        // When
        let identifier = MockClass.className
        // Then
        XCTAssertEqual(identifier, "MockClass")
    }
}

fileprivate final class MockClass: ClassIdentifiable { }
