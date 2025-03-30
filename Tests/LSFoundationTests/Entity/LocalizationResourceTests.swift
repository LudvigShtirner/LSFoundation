// Apple
import XCTest
// SPM
@testable import LSFoundation

final class LocalizationResourceTests: XCTestCase {
    // MARK: - Tests
    func testThatValueFoundInSpecificLocalizationFile() {
        // Given
        // When
        let result = ExampleLocalization.someInfo
        // Then
        XCTAssertEqual(result, "Some info")
    }
    
    func testThatValueFoundInCommonLocalizationFile() {
        // Given
        // When
        let result = ExampleLocalization.agree
        // Then
        XCTAssertEqual(result, "Agree")
    }
    
    func testThatKeyReturnedWhenNoResultsFound() {
        // Given
        // When
        let result = ExampleLocalization.noLocalization
        // Then
        XCTAssertEqual(result, "NO_LOCALIZATION")
    }
    
    func test_defaultSpecificTable_nameEqualClass() {
        let commonData = Environment.commonTable
        let tableData = Environment.specificTable
        XCTAssertEqual(commonData.tableName, "TestLocalizable")
        XCTAssertEqual(tableData.tableName, "Environment")
    }
}

// MARK: - Stubs
/// Example of localization in project
fileprivate class ExampleLocalization: LocalizationResource {
    // MARK: - Data
    static let someInfo = localize(for: "TEST_EXAMPLE_SOME")
    static let agree = localize(for: "TEST_AGREE")
    static let noLocalization = localize(for: "NO_LOCALIZATION")
    
    // MARK: - LocalizationResource
    static var specificTable: (bundle: Bundle, tableName: String) {
        return (Bundle.module, "ExampleLocalization")
    }
    
    static var commonTable: (bundle: Bundle, tableName: String) {
        return (Bundle.module, "TestLocalizable")
    }
}

private final class Environment: LocalizationResource {
    static var commonTable: (bundle: Bundle, tableName: String) {
        return (Bundle.module, "TestLocalizable")
    }
}
