//
//  DateFormatterTransformsTests.swift
//
//
//  Created by Алексей Филиппов on 29.09.2024.
//

// Apple
import XCTest

final class DateFormatterTransformsTests: XCTestCase {
    // MARK: - Tests
    func test_dateFormatter_monthName_successed() {
        // Given
        let dateFormatter = DateFormatter.shared
        let date = Date(timeIntervalSince1970: 0)
        // When
        let result = dateFormatter.makeMonthString(from: date).capitalized
        // Then
        XCTAssertEqual(result, "Январь")
    }
}
