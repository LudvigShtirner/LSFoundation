// Apple
import Foundation

@propertyWrapper
public final class Cached<Value> {
    // MARK: - Data
    private var value: Value?
    private var getValue: () -> Value
    
    // MARK: - Inits
    public init(wrappedValue: Value? = nil,
                getValue: @escaping () -> Value) {
        self.value = wrappedValue
        self.getValue = getValue
    }
    
    // MARK: - Interface methods
    public var wrappedValue: Value {
        get {
            if let value {
                return value
            }
            let value = getValue()
            self.value = value
            return value
        }
        set {
            value = newValue
        }
    }
    
    public func flush() {
        value = nil
    }
}
