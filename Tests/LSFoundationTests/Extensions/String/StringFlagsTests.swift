//
//  StringFlagsTests.swift
//
//
//  Created by Алексей Филиппов on 29.09.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class StringFlagsTests: XCTestCase {
    func test_makeCanadaFlag_successed() {
        // Given
        // When
        let result = String.emojiFlag(countryCode: "CA")
        // Then
        XCTAssertEqual(result, "🇨🇦")
    }
    
    func test_makeCanadaFlag_failed() {
        // Given
        // When
        let result = String.emojiFlag(countryCode: "CAN")
        // Then
        XCTAssertEqual(result, nil)
    }
    
    func test_makeScotlandFlag_successed() {
        // Given
        // When
        let result = String.emojiFlag(subdivision: "GBSCT")
        // Then
        XCTAssertEqual(result, "🏴󠁧󠁢󠁳󠁣󠁴󠁿")
    }
    
    func test_makeScotlandFlag_failed() {
        // Given
        // When
        let result = String.emojiFlag(subdivision: "GBSC")
        // Then
        XCTAssertEqual(result, "🏴󠁧󠁢󠁳󠁣󠁿")
    }
}
