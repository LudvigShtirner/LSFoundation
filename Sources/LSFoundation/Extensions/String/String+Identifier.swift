//
//  String+Identifier.swift
//
//
//  Created by Алексей Филиппов on 09.04.2024.
//

import Foundation

public extension String {
    static var uniqueIdentifier: String {
        ProcessInfo.processInfo.globallyUniqueString
    }
}
