// SPM
import LSFoundation
// Apple
import XCTest

final class ProgressTimerTests: XCTestCase {
    // MARK: - Tests
    func test_progressTimer_isActive_afterStart() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        let isActive = sut.isActive
        XCTAssertFalse(isActive)
        XCTAssertNoThrow(
            try sut.start(
                updateStep: 0.1,
                finishTime: 0.3,
                handle: { _ in }
            )
        )
        environment.isActive = sut.isActive
        XCTAssertTrue(environment.isActive)
        // Then
        XCTAssertTrue(environment.isActive)
    }
    
    func test_progressTimer_start_avoidRepeatedStart() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        let expectation = expectation(description: #function)
        // When
        XCTAssertNoThrow(
            try sut.start(
                updateStep: 0.1,
                finishTime: 0.3
            ) { notifier in
                notifier.addSubscriber(environment) { _ in
                    if environment.isFirstTimerCalledOnce {
                        return
                    }
                    environment.isFirstTimerCall = true
                    environment.isFirstTimerCalledOnce = true
                    expectation.fulfill()
                }
            }
        )
        XCTAssertThrowsError(
            try sut.start(
                updateStep: 0.1,
                finishTime: 0.3
            ) { notifier in
                notifier.addSubscriber(environment) { _ in
                    if environment.isSecondTimerCalledOnce {
                        return
                    }
                    environment.isSecondTimerCall = true
                    environment.isSecondTimerCalledOnce = true
                }
            }
        )
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
        XCTAssertNoThrow(
            try sut.start(
                updateStep: 0.1,
                finishTime: 0.3
            ) { _ in }
        )
        environment.isActive = sut.isActive
        XCTAssertTrue(environment.isActive)
        XCTAssertNoThrow(
            try sut.stop()
        )
        environment.isActive = sut.isActive
        XCTAssertThrowsError(
            try sut.stop()
        )
        environment.isActive = sut.isActive
        // Then
        XCTAssertFalse(environment.isActive)
    }
}

private final class Environment: Sendable {
    
    nonisolated(unsafe) var isActive = false
    
    nonisolated(unsafe) var isFirstTimerCall = false
    nonisolated(unsafe) var isFirstTimerCalledOnce = false
    nonisolated(unsafe) var isSecondTimerCall = false
    nonisolated(unsafe) var isSecondTimerCalledOnce = false
    
    func makeSut() -> ProgressTimer {
        return ProgressTimer()
    }
}
