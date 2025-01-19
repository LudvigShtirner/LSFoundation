//
//  Optional+Utils.swift
//
//
//  Created by Алексей Филиппов on 17.08.2024.
//

// Apple
import Foundation

public extension Optional {
    var isNil: Bool {
        switch self {
        case .none: return true
        case .some: return false
        }
    }
}
