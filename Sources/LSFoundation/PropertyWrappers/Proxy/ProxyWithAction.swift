// Apple
import Foundation

@propertyWrapper
public struct AnyProxyWithAction<EnclosingType, Value> {
    // MARK: - Data
    private let keyPath: ReferenceWritableKeyPath<EnclosingType, Value>
    private let extraAction: (EnclosingType, Value) -> Void
    
    // MARK: - Inits
    public init(_ keyPath: ReferenceWritableKeyPath<EnclosingType, Value>,
                extraAction: @escaping (EnclosingType, Value) -> Void) {
        self.keyPath = keyPath
        self.extraAction = extraAction
    }
    
    // MARK: - Interface methods
    public static subscript(_enclosingInstance instance: EnclosingType,
                            wrapped wrappedKeyPath: KeyPath<EnclosingType, Value>,
                            storage storageKeyPath: KeyPath<EnclosingType, Self>) -> Value {
        get {
            let wrapper = instance[keyPath: storageKeyPath]
            return instance[keyPath: wrapper.keyPath]
        }
        set {
            let wrapper = instance[keyPath: storageKeyPath]
            instance[keyPath: wrapper.keyPath] = newValue
            wrapper.extraAction(instance, newValue)
        }
    }
    
    @available(*, unavailable, message: "@Proxy can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError("wrappedValue getter isn't accessed") }
        set { assertionFailure("wrappedValue setter isn't accessed") }
    }
}
