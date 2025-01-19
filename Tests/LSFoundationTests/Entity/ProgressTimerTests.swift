//
//  ProgressTimerTests.swift
//
//
//  Created by Алексей Филиппов on 20.07.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest
import Combine

final class ProgressTimerTests: XCTestCase {
    // MARK: - Tests
    func test_progressTimer_isActive_afterStart() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        XCTAssertFalse(sut.isActive)
        sut.start(updateStep: 0.1, finishTime: 0.3, handle: { _ in })
        // Then
        XCTAssertTrue(sut.isActive)
    }
    
    func test_progressTimer_start_avoidRepeatedStart() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        let expectation = expectation(description: #function)
        // When
        sut.start(updateStep: 0.1,
                  finishTime: 0.3) { notifier in
            notifier.sink { _ in
                if environment.isFirstTimerCalledOnce {
                    return
                }
                environment.isFirstTimerCall = true
                environment.isFirstTimerCalledOnce = true
                expectation.fulfill()
            }
            .store(in: &environment.cancellables)
        }
        sut.start(updateStep: 0.1,
                  finishTime: 0.3) { notifier in
            notifier.sink { _ in
                if environment.isSecondTimerCalledOnce {
                    return
                }
                environment.isSecondTimerCall = true
                environment.isSecondTimerCalledOnce = true
            }
            .store(in: &environment.cancellables)
        }
        // Then
        wait(for: [expectation], timeout: 0.3)
        XCTAssertTrue(environment.isFirstTimerCalledOnce)
        XCTAssertTrue(environment.isFirstTimerCall)
        XCTAssertFalse(environment.isSecondTimerCalledOnce)
        XCTAssertFalse(environment.isSecondTimerCall)
    }
    
    func test_progressTimer_stop_avoidRepeatedStop() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        sut.start(updateStep: 0.1,
                  finishTime: 0.3) { _ in }
        sut.stop()
        XCTAssertFalse(sut.isActive)
        sut.stop()
        // Then
        XCTAssertFalse(sut.isActive)
    }
}

private final class Environment {
    
    var cancellables = Set<AnyCancellable>()
    var isFirstTimerCall = false
    var isFirstTimerCalledOnce = false
    var isSecondTimerCall = false
    var isSecondTimerCalledOnce = false
    
    func makeSut() -> ProgressTimer {
        return ProgressTimer()
    }
}
