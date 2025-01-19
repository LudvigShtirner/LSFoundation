//
//  Toggled.swift
//  
//
//  Created by Филиппов Алексей on 22.06.2022.
//

// Apple
import Foundation

@propertyWrapper
public struct Toggled<Value> {
    // MARK: - Data
    private var currentValue: Value
    private var anotherValue: Value
    
    // MARK: - Inits
    public init(wrappedValue value: Value, anotherValue: Value) {
        self.anotherValue = anotherValue
        self.currentValue = value
        wrappedValue = value
    }
    
    // MARK: - PropertyWrapper
    public var wrappedValue: Value {
        get { currentValue }
        set { currentValue = newValue }
    }
    
    // MARK: - Interface methods
    public mutating func toggle() {
        let tmp = anotherValue
        anotherValue = currentValue
        currentValue = tmp
    }
}
