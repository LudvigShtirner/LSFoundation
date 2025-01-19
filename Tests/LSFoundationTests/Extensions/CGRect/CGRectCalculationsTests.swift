//
//  CGRectCalculationsTests.swift
//
//
//  Created by Алексей Филиппов on 29.09.2024.
//

// Apple
import XCTest

final class CGRectCalculationsTests: XCTestCase {
    func test_CGRect_minSide_choosesWidth() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.minSide
        // Then
        XCTAssertEqual(result, 6)
    }
    
    func test_CGRect_minSide_choosesHeight() {
        // Given
        let rect = Environment().rect2
        // When
        let result = rect.minSide
        // Then
        XCTAssertEqual(result, 8)
    }
    
    func test_CGRect_diagonal_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.diagonal
        // Then
        XCTAssertEqual(result, 10)
    }
    
    func test_CGRect_topLeftPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.topLeftPoint
        // Then
        XCTAssertEqual(result, .zero)
    }
    
    func test_CGRect_topRightPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.topRightPoint
        // Then
        XCTAssertEqual(result, .init(x: 6, y: .zero))
    }
    
    func test_CGRect_bottomLeftPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.bottomLeftPoint
        // Then
        XCTAssertEqual(result, .init(x: .zero, y: 8))
    }
    
    func test_CGRect_bottomRightPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.bottomRightPoint
        // Then
        XCTAssertEqual(result, .init(x: 6, y: 8))
    }
    
    func test_CGRect_topCenterPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.topCenter
        // Then
        XCTAssertEqual(result, .init(x: 3, y: .zero))
    }
    
    func test_CGRect_leftCenterPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.leftCenter
        // Then
        XCTAssertEqual(result, .init(x: .zero, y: 4))
    }
    
    func test_CGRect_bottomCenterPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.bottomCenter
        // Then
        XCTAssertEqual(result, .init(x: 3, y: 8))
    }
    
    func test_CGRect_rightCenterPoint_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.rightCenter
        // Then
        XCTAssertEqual(result, .init(x: 6, y: 4))
    }
    
    func test_CGRect_center_successed() {
        // Given
        let rect = Environment().rect1
        // When
        let result = rect.center
        // Then
        XCTAssertEqual(result, .init(x: 3, y: 4))
    }
    
    func test_CGRect_setCenter_successed() {
        // Given
        var rect = Environment().rect1
        // When
        rect.center = .init(x: 5, y: 5)
        // Then
        let result = rect.origin
        XCTAssertEqual(result, .init(x: 2, y: 1))
    }
}

private final class Environment {
    let rect1 = CGRect(origin: .zero,
                       size: .init(width: 6, height: 8))
    let rect2 = CGRect(origin: .zero,
                       size: .init(width: 10, height: 8))
}
