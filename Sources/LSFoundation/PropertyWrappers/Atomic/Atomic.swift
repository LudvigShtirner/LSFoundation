//
//  Atomic.swift
//  
//
//  Created by Алексей Филиппов on 18.06.2023.
//

// Apple
import Foundation

@propertyWrapper
public final class Atomic<Value>: @unchecked Sendable {
    // MARK: - Data
    private let lock = NSLock()
    private var value: Value
    
    // MARK: - Inits
    public init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    // MARK: - Interface methods
    public var projectedValue: Atomic<Value> { self }
    
    public var wrappedValue: Value {
        get {
            lock.lock()
            let result = value
            lock.unlock()
            return result
        }
        set {
            assertionFailure("use mutate func instead")
        }
    }
    
    public func mutate(_ mutation: (inout Value) -> Void) {
        lock.lock()
        mutation(&value)
        lock.unlock()
    }
}
