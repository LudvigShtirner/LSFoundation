// Apple
import XCTest

final class OptionalsUtilsTests: XCTestCase {
    func test_isNil_returnsTrue() {
        // Given
        let optional: Int? = nil
        // When
        let result = optional.isNil
        // Then
        XCTAssertTrue(result)
    }
    
    func test_isNil_returnsFalse() {
        // Given
        let optional: Int? = 5
        // When
        let result = optional.isNil
        // Then
        XCTAssertFalse(result)
    }
}
