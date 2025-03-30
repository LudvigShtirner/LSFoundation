// Apple
import XCTest

class CGRectEqualTests: XCTestCase {
    // MARK: - Tests
    func testThatCGRectsAreEqual() {
        // Given
        let x = 100
        let y = 200
        let width = 300
        let height = 400
        let rect1 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        let rect2 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        // When
        let result = rect1.isAlmostEqual(to: rect2)
        // Then
        XCTAssertTrue(result)
    }
    
    func testThatCGRectsAreAlmostEqual() {
        // Given
        let x: CGFloat = 100
        let y: CGFloat = 200
        let width: CGFloat = 300
        let height: CGFloat = 400
        let rect1 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        let rect2 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height - .ulpOfOne)
        // When
        let result = rect1.isAlmostEqual(to: rect2)
        // Then
        XCTAssertTrue(result)
    }
    
    func testThatCGRectsAreNotAlmostEqual() {
        // Given
        let x: CGFloat = 100
        let y: CGFloat = 200
        let width: CGFloat = 300
        let height: CGFloat = 400
        let rect1 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        let fixedHeight = height - 0.0000000000001
        let rect2 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: fixedHeight)
        // When
        let result = rect1.isAlmostEqual(to: rect2)
        // Then
        XCTAssertFalse(result)
    }
    
    func testThatCGRectsAreAlmostEqualWithError() {
        // Given
        let x: CGFloat = 100
        let y: CGFloat = 200
        let width: CGFloat = 300
        let height: CGFloat = 400
        let error: CGFloat = 0.0001
        let rect1 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        let rect2 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height - error.half)
        // When
        let result = rect1.isAlmostEqual(to: rect2, error: error)
        // Then
        XCTAssertTrue(result)
    }
    
    func testThatCGRectsAreNotAlmostEqualWithError() {
        // Given
        let x: CGFloat = 100
        let y: CGFloat = 200
        let width: CGFloat = 300
        let height: CGFloat = 400
        let error: CGFloat = 0.0001
        let rect1 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height)
        let rect2 = CGRect(x: x,
                           y: y,
                           width: width,
                           height: height - 2 * error)
        // When
        let result = rect1.isAlmostEqual(to: rect2, error: error)
        // Then
        XCTAssertFalse(result)
    }
}
