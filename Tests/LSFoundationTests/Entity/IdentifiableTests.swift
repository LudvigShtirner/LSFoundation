// Apple
import XCTest
// SPM
@testable import LSFoundation

final class IdentifiableTests: XCTestCase {
    // MARK: - Tests
    func testThatIdentifiableReturnsClassName() {
        // Given
        // When
        let identifier = MockClass.className
        // Then
        XCTAssertEqual(identifier, "MockClass")
    }
}

fileprivate final class MockClass: ClassIdentifiable { }
