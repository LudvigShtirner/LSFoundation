//
//  DoubleTimeFormatTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 12.05.2022.
//

// Apple
import XCTest

final class DoubleTimeFormatTests: XCTestCase {
    // MARK: - Tests
    func testThatDurationConvertedToTimeFormatWithoutHours() {
        // Given
        let duration = 363.0
        // When
        let timeFormat = duration.timeFormat()
        // Then
        XCTAssertEqual(timeFormat, "06:03")
    }
    
    func testThatDurationConvertedToTimeFormatWithHours() {
        // Given
        let duration = 3963.0
        // When
        let timeFormat = duration.timeFormat()
        // Then
        XCTAssertEqual(timeFormat, "01:06:03")
    }
}
