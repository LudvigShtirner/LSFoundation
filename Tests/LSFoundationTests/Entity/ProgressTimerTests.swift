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
        let expectation = expectation(description: #function)
        // When
        Task {
            let isActive = await sut.isActive
            XCTAssertFalse(isActive)
            do {
                try await sut.start(
                    updateStep: 0.1,
                    finishTime: 0.3,
                    handle: { _ in }
                )
            } catch let error {
                XCTFail(error.localizedDescription)
            }
            environment.isActive = await sut.isActive
            XCTAssertTrue(environment.isActive)
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(environment.isActive)
    }
    
    func test_progressTimer_start_avoidRepeatedStart() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        let expectation = expectation(description: #function)
        // When
        Task {
            do {
                try await sut.start(
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
            } catch let error {
                XCTFail(error.localizedDescription)
            }
            do {
                try await sut.start(
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
            } catch {}
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
        let expectation = expectation(description: #function)
        // When
        Task {
            do {
                try await sut.start(
                    updateStep: 0.1,
                    finishTime: 0.3
                ) { _ in }
                environment.isActive = await sut.isActive
                XCTAssertTrue(environment.isActive)
                try await sut.stop()
            } catch let error {
                XCTFail(error.localizedDescription)
            }
            environment.isActive = await sut.isActive
            do {
                try await sut.stop()
            } catch {}
            environment.isActive = await sut.isActive
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 1)
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
