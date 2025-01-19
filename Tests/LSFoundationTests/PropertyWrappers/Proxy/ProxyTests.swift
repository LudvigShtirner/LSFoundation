//
//  ProxyTests.swift
//  
//
//  Created by Алексей Филиппов on 29.09.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class ProxyTests: XCTestCase {
    // MARK: - Tests
    func test_proxy_setValue_correctly() {
        // Given
        let environment = Environment()
        // When
        XCTAssertEqual(environment.someProperty, 5)
        environment.someProperty = 10
        // Then
        XCTAssertEqual(environment.someProperty, 10)
    }
}

private final class Environment {
    var example = Example()
    
    @AnyProxy(\Environment.example.innerProperty)
    var someProperty: Int
}

private final class Example {
    var innerProperty: Int = 5
}

