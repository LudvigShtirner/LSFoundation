// Apple
import Foundation
import Combine

/// Provides progress updates by time interval.
/// - Important: Blocks non-main thread
public final class ProgressTimer {
    // MARK: - Data
    private let state: ProgressTimerState
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Inits
    public init() {
        self.state = ProgressTimerState()
    }
    
    // MARK: - Interface methods
    public var isActive: Bool { state.isActive }
    
    /// Launches timer with updates by time intervals with overall time
    /// - Parameters:
    ///   - updateStep: Time interval between updates fired
    ///   - finishTime: duration of timer work
    ///   - handle: configuration block with progress publisher
    public func start(updateStep: TimeInterval,
                      finishTime: TimeInterval,
                      handle: (CurrentValueSubject<Double, Never>) -> Void) {
        guard let idle = state.idle else {
            return
        }
        let running = idle.makeRunning(updateStep: updateStep,
                                       finishTime: finishTime)
        self.state.running = running
        running.progress
            .sink { [weak self] progress in
                if progress / finishTime >= 1.0 {
                    self?.stop()
                }
            }
            .store(in: &cancellables)
        handle(running.progress)
        running.start()
    }
    
    /// invalidate timer and stop publishing updates
    public func stop() {
        guard let timer = state.running else {
            return
        }
        state.idle = timer.stop()
    }
}

// MARK: - State
private final class ProgressTimerState {
    var idle: IdleProgressTimer? {
        didSet {
            guard idle != nil else { return }
            running = nil
        }
    }
    var running: RunningProgressTimer? {
        didSet {
            guard running != nil else { return }
            idle = nil
        }
    }
    
    init() {
        idle = IdleProgressTimer()
    }
    
    var isActive: Bool {
        guard running != nil else { return false }
        return true
    }
}

// MARK: - Idle
private struct IdleProgressTimer {
    // MARK: - Interface methods
    func makeRunning(updateStep: TimeInterval,
                     finishTime: TimeInterval) -> RunningProgressTimer {
        RunningProgressTimer(updateStep: updateStep,
                             finishTime: finishTime)
    }
}

// MARK: - Running
private final class RunningProgressTimer {
    // MARK: - Data
    private let updateStep: TimeInterval
    private let finishTime: TimeInterval
    private var timer: Timer!
    
    let progress: CurrentValueSubject<Double, Never> = .init(0)
    private var shouldKeepRunning = false
    
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
        progress.value += updateStep
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
        while shouldKeepRunning {
            RunLoop.current.run(until: Date.now.advanced(by: updateStep * 2))
            keepingActive()
        }
    }
}
