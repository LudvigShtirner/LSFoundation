//
//  UserDefaultsPropertyWrapper.swift
//  SupportCode
//
//  Created by Филиппов Алексей on 12.05.2022.
//

// Apple
import Foundation
import Combine

/// Property wrapper for userDefaults. Store and obtain data
@propertyWrapper
public struct UDStored<T: Codable> {
    public var wrappedValue: T {
        get {
            storage.object(forKey: key.stringValue) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key.stringValue)
        }
    }
    
    private let key: UserDefaultsKey
    private let defaultValue: T
    private let storage: UserDefaults
    
    public init(key: UserDefaultsKey,
                defaultValue: T,
                storage: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

/// Property wrapper for userDefaults. Store and obtain Codable data. Encoding and Decoding by JSON
@propertyWrapper
public struct UDCodableStored<T: JsonCodable> {
    public var wrappedValue: T {
        get {
            guard let data = storage.data(forKey: key.stringValue) else {
                return defaultValue
            }
            return try! T.decode(from: data)
        }
        set {
            let data = try! newValue.encode()
            storage.set(data, forKey: key.stringValue)
        }
    }
    
    private let key: UserDefaultsKey
    private let defaultValue: T
    private let storage: UserDefaults
    
    public init(key: UserDefaultsKey,
                defaultValue: T,
                storage: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
}

@propertyWrapper
public struct UDStoredRx<T: Codable> {
    public var wrappedValue: T {
        get {
            storage.object(forKey: key.stringValue) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key.stringValue)
            currentValue.send(newValue)
        }
    }
    
    public var projectedValue: Self { self }
    public var publisher: CurrentValueSubject<T, Never> { currentValue }
    
    private let key: UserDefaultsKey
    private let defaultValue: T
    private let storage: UserDefaults
    private let currentValue: CurrentValueSubject<T, Never>
    
    public init(key: UserDefaultsKey,
                defaultValue: T,
                storage: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        self.currentValue = .init(defaultValue)
    }
}

@propertyWrapper
public struct UDCodableStoredRx<T: JsonCodable> {
    public var wrappedValue: T {
        get {
            guard let data = storage.data(forKey: key.stringValue) else {
                return defaultValue
            }
            return try! T.decode(from: data)
        }
        set {
            let data = try! newValue.encode()
            storage.set(data, forKey: key.stringValue)
            currentValue.send(newValue)
        }
    }
    public var publisher: AnyPublisher<T, Never> { currentValue.eraseToAnyPublisher() }
    
    private let key: UserDefaultsKey
    private let defaultValue: T
    private let storage: UserDefaults
    private let currentValue: CurrentValueSubject<T, Never>
    
    public init(key: UserDefaultsKey,
                defaultValue: T,
                storage: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
        self.currentValue = .init(defaultValue)
    }
}
