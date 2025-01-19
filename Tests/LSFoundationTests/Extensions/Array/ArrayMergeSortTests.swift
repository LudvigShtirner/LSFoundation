//
//  ArrayMergeSortTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 16.05.2022.
//

// Apple
import XCTest
// SPM
class ArrayMergeSortTests: XCTestCase {
    // MARK: - Tests
    func testThatMergeSortWorks() {
        // Given
        let array = [1024, 512, 128, 256, 16, 8, 4, 32, 64, 2, 1]
        let expectedResult = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]
        // When
        let result = array.mergeSort()
        // Then
        XCTAssertEqual(result, expectedResult)
    }
}
