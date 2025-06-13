public final class Atomic<Value: Sendable>: Sendable {
    // MARK: - Data
    private let lock = NSLock()
    private nonisolated(unsafe) var value: Value
    
    // MARK: - Inits
    public init(_ value: Value) {
        self.value = value
    }
    
    // MARK: - Interface methods
    
    public func withLock<R>(_ body: @Sendable (inout Value) -> R) -> R where R : Sendable {
        lock.withLock { body(&value) }
    }
    
    public func withLockUnchecked<R>(_ body: (inout Value) -> R) -> R {
        lock.withLock { body(&value) }
    }
    
    // throwable version of functions above
    public func withLock<R>(_ body: @Sendable (inout Value) throws -> R) rethrows -> R where R : Sendable {
        try lock.withLock { try body(&value) }
    }
    
    public func withLockUnchecked<R>(_ body: (inout Value) throws -> R) rethrows -> R {
        try lock.withLock { try body(&value) }
    }
}
