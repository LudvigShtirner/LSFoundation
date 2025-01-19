//
//  StringUtilsTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 16.05.2022.
//

// Apple
import XCTest

class StringUtilsTests: XCTestCase {
    // MARK: - Data
    let string = "Metallica - The Unforgiven II.mp3"
    
    // MARK: - Tests
    func testThatSubscriptReturnCorrectCharacter() {
        // Given
        // When
        let character = string[10]
        // Then
        XCTAssertEqual(character, "-")
    }
    
    func testThatSubscriptDoesNotReturnCharacterWhenOutOfBounds() {
        // Given
        // When
        let character = string[33]
        // Then
        XCTAssertNil(character)
    }
    
    func testThatSubscriptReturnsSubstring() {
        // Given
        // When
        let substring = string[10 ..< 30]
        // Then
        XCTAssertEqual(substring, "- The Unforgiven II.")
    }
    
    func testThatSubscriptHandleRangeUpperValueMoreThanLength() {
        // Given
        // When
        let substring = string[10 ..< 40]
        // Then
        XCTAssertEqual(substring, "- The Unforgiven II.mp3")
    }
    
    func testSubstringFromIndex() {
        // Given
        let emptyString = ""
        // When
        let substring1 = string.substring(fromIndex: 0)
        let substring2 = string.substring(fromIndex: 10)
        let substring3 = string.substring(fromIndex: 20)
        let substring4 = string.substring(fromIndex: 30)
        let substring5 = string.substring(fromIndex: 40)
        let emptySubstring = emptyString.substring(fromIndex: 10)
        // Then
        XCTAssertEqual(substring1, string)
        XCTAssertEqual(substring2, "- The Unforgiven II.mp3")
        XCTAssertEqual(substring3, "rgiven II.mp3")
        XCTAssertEqual(substring4, "mp3")
        XCTAssertEqual(substring5, "")
        XCTAssertEqual(emptySubstring, "")
    }
    
    func testSubstringToIndex() {
        // Given
        let emptyString = ""
        // When
        let substring1 = string.substring(toIndex: 0)
        let substring2 = string.substring(toIndex: 10)
        let substring3 = string.substring(toIndex: 20)
        let substring4 = string.substring(toIndex: 30)
        let substring5 = string.substring(toIndex: 40)
        let emptySubstring = emptyString.substring(toIndex: 10)
        // Then
        XCTAssertEqual(substring1, "")
        XCTAssertEqual(substring2, "Metallica ")
        XCTAssertEqual(substring3, "Metallica - The Unfo")
        XCTAssertEqual(substring4, "Metallica - The Unforgiven II.")
        XCTAssertEqual(substring5, string)
        XCTAssertEqual(emptySubstring, "")
    }
}
