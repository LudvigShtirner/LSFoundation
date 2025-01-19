//
//  PublisherUtilsTests.swift
//
//
//  Created by Алексей Филиппов on 29.09.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest
import Combine

final class PublisherUtilsTests: XCTestCase {
    func test_Publisher_mainQueueModifier_changesQueue() {
        // Given
        let expectation = XCTestExpectation()
        var flag = false
        let publisher = CurrentValueSubject<Int, Never>(5)
        let cancellable = publisher
            .receiveOnMainQueue()
            .sink { value in
                guard Thread.isMainThread,
                      value == 10 else {
                    return
                }
                flag = true
                expectation.fulfill()
            }
        // When
        DispatchQueue.global(qos: .userInteractive).async {
            publisher.send(10)
        }
        // Then
        XCTAssertFalse(flag)
        wait(for: [expectation], timeout: 0.1)
        XCTAssertTrue(flag)
        cancellable.cancel()
    }
}
