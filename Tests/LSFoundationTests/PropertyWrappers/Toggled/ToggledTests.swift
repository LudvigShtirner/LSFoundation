//
//  ToggledTests.swift
//  
//
//  Created by Алексей Филиппов on 05.08.2022.
//

// Apple
import XCTest
// SPM
import LSFoundation

class ToggledTests: XCTestCase {
    // MARK: - Tests
    func testThatToggledCreatedCorrectly() {
        // Given
        // When
        @Toggled(anotherValue: 50) var result = 10
        // Then
        XCTAssertEqual(result, 10)
    }
    
    func testThatToggledChangeValue() {
        // Given
        @Toggled(anotherValue: 50) var result = 10
        // When
        _result.toggle()
        // Then
        XCTAssertEqual(result, 50)
    }
}
