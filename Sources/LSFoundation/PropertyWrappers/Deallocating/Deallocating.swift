@propertyWrapper @dynamicMemberLookup
public final class Deallocating<Value: AnyObject & Sendable> {
    public var wrappedValue: Value
    private let timeInterval: TimeInterval
 
    public init(wrappedValue: Value, timeInterval: TimeInterval = 1) {
        self.wrappedValue = wrappedValue
        self.timeInterval = timeInterval
    }
 
    subscript<Member>(dynamicMember keyPath: WritableKeyPath<Value, Member>) -> Member {
        get {
            wrappedValue[keyPath: keyPath]
        }
        set {
            wrappedValue[keyPath: keyPath] = newValue
        }
    }
 
    deinit {
        LeakDetection.expectDeallocation(wrappedValue, in: timeInterval)
    }
}
