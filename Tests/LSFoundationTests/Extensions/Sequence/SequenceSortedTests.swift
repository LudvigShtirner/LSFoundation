//
//  SequenceSortedTests.swift
//
//
//  Created by Алексей Филиппов on 17.07.2024.
//

// Apple
import XCTest

final class SequenceSortedTests: XCTestCase {
    // MARK: - Tests
    func testThatSequenceIntSorted() {
        // Given
        let array = Environment.makeSut()
        let expected = array.sorted { $0.int < $1.int }
        // When
        let result = array.sorted(by: \.int)
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testThatSequenceDoubleSorted() {
        // Given
        let array = Environment.makeSut()
        let expected = array.sorted { $0.double < $1.double }
        // When
        let result = array.sorted(by: \.double)
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testThatSequenceStringSorted() {
        // Given
        let array = Environment.makeSut()
        let expected = array.sorted { $0.string < $1.string }
        // When
        let result = array.sorted(by: \.string)
        // Then
        XCTAssertEqual(result, expected)
    }
}

private final class Environment {
    static func makeSut() -> [Example] {
        [
            Example(int: 5,
                    double: 2.3,
                    string: "sdf"),
            Example(int: 9,
                    double: 4.5,
                    string: "werwef"),
            Example(int: 2,
                    double: 1.7,
                    string: "tyhrtyb"),
            Example(int: 3,
                    double: 1.1,
                    string: "23wfefds"),
            Example(int: 7,
                    double: 9.7,
                    string: "zxcdfg"),
            Example(int: 1,
                    double: 7.8,
                    string: "asd"),
            Example(int: 6,
                    double: 5.5,
                    string: "rev"),
            Example(int: 8,
                    double: 3.9,
                    string: "bbnmbnm")
        ]
    }
}

private struct Example: Equatable {
    let int: Int
    let double: Double
    let string: String
}
