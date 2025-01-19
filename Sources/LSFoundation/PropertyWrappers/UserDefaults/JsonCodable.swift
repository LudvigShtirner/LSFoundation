//
//  JsonCodable.swift
//  SupportCode
//
//  Created by Филиппов Алексей on 16.05.2022.
//

// Apple
import Foundation

public protocol JsonCodable: Codable {
    func encode() throws -> Data
    static func decode(from data: Data) throws -> Self
}

public extension JsonCodable {
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    static func decode(from data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
}
