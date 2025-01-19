//
//  ProxyWithActionTests.swift
//
//
//  Created by Алексей Филиппов on 21.07.2024.
//

// SPM
import LSFoundation
// Apple
import XCTest

final class ProxyWithActionTests: XCTestCase {
    // MARK: - Tests
    func test_proxyWithAction_callsAction_onSet() {
        // Given
        let environment = Environment()
        var result = 0
        environment.updateBlock = {
            result = $0
        }
        // When
        XCTAssertEqual(environment.someProperty, 5)
        environment.someProperty = 10
        // Then
        XCTAssertEqual(result, 10)
    }
}

private final class Environment {
    var example = Example()
    
    @AnyProxyWithAction(\Environment.example.innerProperty,
                         extraAction: { environment, value in environment.update(value) })
    var someProperty: Int
    
    var updateBlock: IntBlock?
    func update(_ value: Int) {
        updateBlock?(value)
    }
}

private final class Example {
    var innerProperty: Int = 5
}
