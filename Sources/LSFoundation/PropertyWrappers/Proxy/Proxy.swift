//
//  Proxy.swift
//
//
//  Created by Алексей Филиппов on 22.11.2023.
//

// Apple
import Foundation

@propertyWrapper
public struct AnyProxy<EnclosingType, Value> {
    // MARK: - Data
    private let keyPath: ReferenceWritableKeyPath<EnclosingType, Value>
    
    // MARK: - Inits
    public init(_ keyPath: ReferenceWritableKeyPath<EnclosingType, Value>) {
        self.keyPath = keyPath
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
        }
    }
    
    @available(*, unavailable, message: "@Proxy can only be applied to classes")
    public var wrappedValue: Value {
        get { fatalError("wrappedValue getter isn't accessed") }
        set { assertionFailure("wrappedValue setter isn't accessed") }
    }
}

public protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self, T>
    typealias ProxyWithAction<T> = AnyProxyWithAction<Self, T>
}

extension NSObject: ProxyContainer {}
