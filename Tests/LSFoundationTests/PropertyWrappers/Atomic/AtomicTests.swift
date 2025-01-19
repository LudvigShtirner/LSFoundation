//
//  AtomicTests.swift
//  
//
//  Created by Алексей Филиппов on 20.06.2023.
//

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
        @Atomic var intValue = 0
        let group = DispatchGroup()
        // When
        for _ in stride(from: 0, to: 100, by: 1) {
            group.enter()
            queue.async {
                $intValue.mutate { value in
                    value += 1
                }
                group.leave()
            }
        }
        group.wait()

        // Then
        XCTAssertEqual(intValue, 100)
    }
    
    func testThatDictIsAtomic() {
        // Given
        @Atomic var dictValue = [:]
        let group = DispatchGroup()
        // When
        for i in stride(from: 0, to: 100, by: 1) {
            group.enter()
            queue.async {
                $dictValue.mutate { value in
                    value["\(i)"] = i
                }
                group.leave()
            }
        }
        group.wait()

        // Then
        XCTAssertEqual(dictValue.count, 100)
    }
}
