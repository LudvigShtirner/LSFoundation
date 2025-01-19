//
//  UserDefaultsPropertyWrapperTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 12.05.2022.
//

// Apple
import XCTest
// SPM
@testable import LSFoundation

class UserDefaultsPropertyWrapperTests: XCTestCase {
    // MARK: - Data
    private var userDefaultsMock: UserDefaults!
    private let key = UserDefaultsKey(UserDefaultsPropertyWrapperTests.className)
    
    // MARK: - Overrides
    override func setUpWithError() throws {
        try super.setUpWithError()
        let suiteName = key.stringValue
        userDefaultsMock = UserDefaults(suiteName: suiteName)
    }
    
    override func tearDownWithError() throws {
        userDefaultsMock.removeObject(forKey: key.stringValue)
        userDefaultsMock = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests
    func testThatPropertyWrapperReturnsDefaultValue() {
        // Given
        @UDCodableStored(key: key, defaultValue: ExampleCodable.makeDefault(), storage: userDefaultsMock) var sut: ExampleCodable
        // When
        XCTAssertNil(userDefaultsMock.value(forKey: key.stringValue))
        let value = sut.value
        let storedValue = userDefaultsMock.value(forKey: key.stringValue)
        // Then
        XCTAssertEqual(value, "")
        XCTAssertNil(storedValue)
    }

    func testThatPropertyWrapperReturnsStoredValue() {
        // Given
        @UDCodableStored(key: key, defaultValue: ExampleCodable.makeDefault(), storage: userDefaultsMock) var sut: ExampleCodable
        let expectedResult = "Some Value"
        // When
        XCTAssertNil(userDefaultsMock.value(forKey: key.stringValue))
        sut = ExampleCodable(value: expectedResult)
        let value = sut.value
        let storedValue = userDefaultsMock.value(forKey: key.stringValue)
        // Then
        XCTAssertEqual(value, expectedResult)
        XCTAssertNotNil(storedValue)
    }
}

// MARK: - Stubs
struct ExampleCodable: JsonCodable {
    let value: String
    
    static func makeDefault() -> ExampleCodable {
        return ExampleCodable(value: "")
    }
}
