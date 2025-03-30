// SPM
import LSFoundation
// Apple
import XCTest

final class CGPointMathTests: XCTestCase {
    func test_CGPoint_isAlmostEqual_successed() {
        // Given
        let value = CGPoint(x: 10.0 / 5.0,
                            y: 21.0 / 7.0)
        let expected = CGPoint(x: 2, y: 3)
        // When
        let result = value.isAlmostEqual(to: expected)
        // Then
        XCTAssertTrue(result)
    }
    
    func test_CGPoint_isAlmostEqual_withError_successed() {
        // Given
        let value = CGPoint(x: 10.0 / 3.0,
                            y: 21.0 / 9.0)
        let expected = CGPoint(x: 3.333, y: 2.333)
        // When
        let result = value.isAlmostEqual(to: expected, tolerance: 0.001)
        // Then
        XCTAssertTrue(result)
    }
    
    @MainActor func test_CGPoint_toPixelGrid_successed() {
        // Given
        let value = CGPoint(x: 10.1 / 3.0,
                            y: 21.1 / 9.0)
        let expected = CGPoint(x: 3.333, y: 2.333)
        // When
        let newValue = value.toPixelGrid(scale: 3.0)
        // Then
        let result = newValue.isAlmostEqual(to: expected, tolerance: 0.001)
        XCTAssertTrue(result)
    }
}
