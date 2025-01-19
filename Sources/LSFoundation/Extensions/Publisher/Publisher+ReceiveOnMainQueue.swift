//
//  Publisher+ReceiveOnMainQueue.swift
//
//
//  Created by Алексей Филиппов on 23.03.2024.
//

// Apple
import Foundation
import Combine

extension Publisher {
    public func receiveOnMainQueue() -> Publishers.ReceiveOn<Self, DispatchQueue> {
        receive(on: DispatchQueue.main)
    }
}
