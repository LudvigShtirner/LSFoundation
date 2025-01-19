//
//  LeakDetection.swift
//
//
//  Created by Алексей Филиппов on 12.11.2024.
//

import Foundation

public enum LeakDetection {
    public static func expectDeallocation(_ object: AnyObject & Sendable, in timeInterval: TimeInterval = 1) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak object] in
            if let object {
                fatalError("Expected deallocation of \(object)")
            }
        }
    }
}
