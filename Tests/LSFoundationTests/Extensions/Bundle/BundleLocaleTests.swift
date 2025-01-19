//
//  BundleLocaleTests.swift
//  
//
//  Created by Алексей Филиппов on 25.02.2023.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class BundleLocaleTests: XCTestCase {
    // MARK: - Tests
    func testThatLocaleIsRussian() {
        // Given
        let bundleMock = BundleMock(isEmptyLocalizations: false)
        // When
        let isRussian = bundleMock.isRussian
        // Then
        XCTAssertTrue(isRussian)
    }
    
    func testThatLocaleIsNotRussian() {
        // Given
        let bundleMock = BundleMock(isEmptyLocalizations: true)
        // When
        let isRussian = bundleMock.isRussian
        // Then
        XCTAssertFalse(isRussian)
    }
}

fileprivate final class BundleMock: Bundle {
    // MARK: - Data
    private let isEmptyLocalizations: Bool
    
    // MARK: - Inits
    init(isEmptyLocalizations: Bool) {
        self.isEmptyLocalizations = isEmptyLocalizations
        super.init()
    }
    
    // MARK: - Overrides
    override var preferredLocalizations: [String] {
        isEmptyLocalizations ? [] : ["ru"]
    }
}
