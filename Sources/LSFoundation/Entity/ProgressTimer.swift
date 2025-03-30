// Apple
import Foundation

/// Provides progress updates by time interval.
/// - Important: Blocks non-main thread
public final class ProgressTimer: Sendable {
    // MARK: - Data
    private let state: ProgressTimerState
    
    // MARK: - Inits
    public init() {
        self.state = ProgressTimerState()
    }
    
    // MARK: - Interface methods
    public var isActive: Bool {
        get async { await state.isActive }
    }
    
    /// Launches timer with updates by time intervals with overall time
    /// - Parameters:
    ///   - updateStep: Time interval between updates fired
    ///   - finishTime: duration of timer work
    ///   - handle: configuration block with progress publisher
    public func start(
        updateStep: TimeInterval,
        finishTime: TimeInterval,
        handle: (ObservableValue<Double>) -> Void
    ) async throws {
        let running = try await state.makeRunning(
            updateStep: updateStep,
            finishTime: finishTime
        )
        running.progress.addSubscriber(self) { [weak self] progress in
            if progress / finishTime >= 1.0 {
                Task {
                    try await self?.stop()
                }
            }
        }
        handle(running.progress)
        running.start()
    }
    
    /// invalidate timer and stop publishing updates
    public func stop() async throws {
        try await state.makeIdle()
    }
}

// MARK: - State
private actor ProgressTimerState {
    var idle: IdleProgressTimer?
    var running: RunningProgressTimer?
    
    init() {
        idle = IdleProgressTimer()
    }
    
    var isActive: Bool {
        guard running != nil else { return false }
        return true
    }
    
    func makeIdle() throws {
        guard let timer = running else {
            throw ProgressTimerError.alreadyStopped
        }
        self.idle = timer.stop()
        self.running = nil
    }
    
    func makeRunning(
        updateStep: TimeInterval,
        finishTime: TimeInterval
    ) throws -> RunningProgressTimer {
        guard let idle else {
            throw ProgressTimerError.alreadyRunning
        }
        let running = idle.makeRunning(updateStep: updateStep,
                                       finishTime: finishTime)
        self.running = running
        self.idle = nil
        return running
    }
}

enum ProgressTimerError: Error {
    case alreadyStopped
    case alreadyRunning
}

// MARK: - Idle
private struct IdleProgressTimer: Sendable {
    // MARK: - Interface methods
    func makeRunning(updateStep: TimeInterval,
                     finishTime: TimeInterval) -> RunningProgressTimer {
        RunningProgressTimer(updateStep: updateStep,
                             finishTime: finishTime)
    }
}

// MARK: - Running
private final class RunningProgressTimer: Sendable {
    // MARK: - Data
    private let updateStep: TimeInterval
    private let finishTime: TimeInterval
    nonisolated(unsafe) private var timer: Timer!
    
    let progress = ObservableValue<Double>(value: 0)
    nonisolated(unsafe) private var shouldKeepRunning = false
    
    // MARK: - Life cycle
    init(updateStep: TimeInterval,
         finishTime: TimeInterval) {
        self.updateStep = updateStep
        self.finishTime = finishTime
    }
    
    deinit {
        timer.invalidate()
        shouldKeepRunning = false
    }
    
    // MARK: - Interface methods
    func start() {
        timer = Timer.scheduledTimer(timeInterval: updateStep,
                                     target: self,
                                     selector: #selector(timerTick),
                                     userInfo: nil,
                                     repeats: true)
        timer.tolerance = updateStep
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        keepRunning()
    }
    
    func stop() -> IdleProgressTimer {
        timer.invalidate()
        shouldKeepRunning = false
        return IdleProgressTimer()
    }
    
    // MARK: - Private methods
    @objc
    private func timerTick() {
        progress.wrappedValue += updateStep
        keepRunning()
    }
    
    private func keepRunning() {
        if Thread.isMainThread {
            return
        }
        shouldKeepRunning = true
        keepingActive()
    }
    
    @objc
    private func keepingActive() {
        if shouldKeepRunning {
            RunLoop.current.run(until: Date.now.advanced(by: updateStep * 2))
        }
    }
}
