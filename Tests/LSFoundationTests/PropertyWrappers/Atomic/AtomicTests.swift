// Apple
import XCTest
// SPM
import LSFoundation

class AtomicTests: XCTestCase {
    // MARK: - Data
    private let queue = DispatchQueue(label: "com.AtomicTests.concurrent",
                                      qos: DispatchQoS.userInteractive,
                                      attributes: DispatchQueue.Attributes.concurrent)
    
    // MARK: - Tests
    func testThatIntIsAtomic() {
        // Given
        let intValue = Atomic(Int.zero)
        let group = DispatchGroup()
        // When
        for _ in stride(from: 0, to: 100, by: 1) {
            group.enter()
            queue.async {
                intValue.withLock { value in
                    value += 1
                }
                group.leave()
            }
        }
        group.wait()

        // Then
        XCTAssertEqual(intValue.withLock { $0 }, 100)
    }
    
    func testThatDictIsAtomic() {
        // Given
        let dictValue = Atomic<[String: Sendable]>([:])
        let group = DispatchGroup()
        // When
        for i in stride(from: 0, to: 100, by: 1) {
            group.enter()
            queue.async {
                dictValue.withLock { value in
                    value["\(i)"] = i
                }
                group.leave()
            }
        }
        group.wait()

        // Then
        XCTAssertEqual(dictValue.withLock { $0.count }, 100)
    }
}
