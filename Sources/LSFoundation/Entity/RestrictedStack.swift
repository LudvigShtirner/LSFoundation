// Apple
import Foundation

/**
 Restricted collection
 */
public struct RestrictedStack<T> {
    // MARK: - Data
    public private(set) var storage: [T] = []
    private var currentIndex: Int
    private let maxCount: Int
    
    // MARK: - Inits
    public init(initialValue: T?,
                maxCount: Int) {
        if let initialValue {
            self.currentIndex = 0
            self.storage = [initialValue]
        } else {
            self.currentIndex = -1
            self.storage = []
        }
        self.maxCount = maxCount
    }
    
    public init(stored: [T],
                maxCount: Int) {
        self.currentIndex = stored.count - 1
        self.storage = stored
        self.maxCount = maxCount
    }
    
    // MARK: - Interface methods
    /// Value indicates able to move to previous state
    public var hasPreviousState: Bool {
        storage.count > 1 && currentIndex != 0
    }
    
    /// Value indicates able to move to next state
    public var hasNextState: Bool {
        let count = storage.count
        return count > 1 && currentIndex != count - 1
    }
    
    /// Extract previous state without deleting
    /// - Returns: value from stack
    public mutating func obtainPreviousState() -> T? {
        if !hasPreviousState {
            return nil
        }
        self.currentIndex -= 1
        return storage[currentIndex]
    }
    
    /// Extract next state without rewrite
    /// - Returns: value from stack
    public mutating func obtainNextState() -> T? {
        if !hasNextState {
            return nil
        }
        self.currentIndex += 1
        return storage[currentIndex]
    }
    
    /// Push new state into stack
    ///
    /// Removes first state if maximum count reached and rewrites next states from current index
    /// - Parameter state: new value to store
    mutating public func addState(_ state: T) {
        clearRedoActions()
        removeFirstStateIfNeeded()
        storage.append(state)
        currentIndex += 1
    }
    
    /// Clear all stack values
    mutating public func removeAllStates() {
        storage.removeAll()
        currentIndex = -1
    }
    
    // MARK: - Private methods
    /// Удалить все redo состояния
    private mutating func clearRedoActions() {
        if currentIndex == storage.count - 1 {
            return
        }
        storage = Array(storage[0 ... currentIndex])
    }
    
    /// Удалить первое сохраненное состояние, если хранилище полностью заполнено
    private mutating func removeFirstStateIfNeeded() {
        if storage.count < maxCount {
            return
        }
        storage.removeFirst()
        currentIndex -= 1
    }
}
