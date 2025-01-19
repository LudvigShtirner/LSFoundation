// Apple
import Foundation

/// Timer that works correctly outside of main thread or RunLoop.main
public final class BackgroundTimer {
    // MARK: - Subtypes
    private enum State {
        case suspended
        case resumed
    }
    
    // MARK: - Dependencies
    private lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(deadline: .now() + self.timeInterval,
                       repeating: self.timeInterval)
        timer.setEventHandler(handler: { [weak self] in
            self?.eventHandler()
        })
        return timer
    }()
    
    // MARK: - Data
    private var state = State.suspended
    private let timeInterval: TimeInterval
    private let eventHandler: VoidBlock
    
    // MARK: - Inits
    public init(timeInterval: TimeInterval,
                eventHandler: @escaping VoidBlock) {
        self.timeInterval = timeInterval
        self.eventHandler = eventHandler
    }
    
    deinit {
        timer.setEventHandler {}
        timer.cancel()
        resume()
    }
    
    // MARK: - Public methods
    /// Launches the timer
    public func resume() {
        if state == .resumed {
            return
        }
        state = .resumed
        timer.resume()
    }
    
    /// Stops the timer
    public func suspend() {
        if state == .suspended {
            return
        }
        state = .suspended
        timer.suspend()
    }
}
