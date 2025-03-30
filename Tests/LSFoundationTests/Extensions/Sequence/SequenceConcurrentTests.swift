// Apple
import XCTest

final class SequenceConcurrentTests: XCTestCase {
    // MARK: - Tests
    func testAsyncMap() {
        // Given
        let array = [1, 2, 3, 4, 5]
        let expected = [2, 4, 6, 8, 10]
        let expectation = XCTestExpectation(description: #function)
        let result = Result()
        // When
        Task { [result] in
            result.array = await array.asyncMap { $0 * 2 }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(result.array, expected)
    }
    
    func testConcurrentMap() {
        // Given
        let array = [1, 2, 3, 4, 5]
        let expected = [2, 4, 6, 8, 10]
        let expectation = XCTestExpectation(description: #function)
        let result = Result()
        // When
        Task { [result] in
            result.array = await array.concurrentMap { $0 * 2 }
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(result.array, expected)
    }
}

private final class Result: @unchecked Sendable {
    var array: [Int] = []
}
