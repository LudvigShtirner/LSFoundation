//
//  MirrorObjectTests.swift
//
//
//  Created by Алексей Филиппов on 20.07.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class MirrorObjectTests: XCTestCase {
    // MARK: - Tests
    func test_mirrorObject_extract_privateProperty() {
        // Given
        let example = Example()
        let sut = MirrorObject(reflecting: example)
        // When
        let value: Int? = sut.extract(variableName: "privateProperty")
        // Then
        XCTAssertEqual(value, 5)
    }
    
    func test_mirrorObject_extract_returnsNilOnTypo() {
        // Given
        let example = Example()
        let sut = MirrorObject(reflecting: example)
        // When
        let value: Int? = sut.extract(variableName: "privatePropert")
        // Then
        XCTAssertNil(value)
    }
}

private final class Example: NSObject {
    private var privateProperty = 5
}
