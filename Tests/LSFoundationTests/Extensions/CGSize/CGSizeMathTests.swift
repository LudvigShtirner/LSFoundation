//
//  CGSizeMathTests.swift
//  SupportCodeTests
//
//  Created by Филиппов Алексей on 13.05.2022.
//

// Apple
import XCTest
// SPM
@testable import LSFoundation

class CGSizeMathTests: XCTestCase {
    // MARK: - Tests
    func testThatSizeInsideCalculatedCorrectly() {
        // Given
        let size = CGSize(width: 640, height: 640)
        let aspectRatio: CGFloat = 640 / 480
        let expectedResult = CGSize(width: 640, height: 480)
        // When
        let result = size.sizeInside(with: aspectRatio)
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThatSizeInsideCannotCalculatedWithZeroAspectRatio() {
        testSizeInsideWithAspectRatio(.zero)
    }
    
    func testThatSizeInsideCannotCalculatedWithNanAspectRatio() {
        testSizeInsideWithAspectRatio(.nan)
    }
    
    func testThatSizeInsideCannotCalculatedWithInfinityAspectRatio() {
        testSizeInsideWithAspectRatio(.infinity)
    }
    
    func testThatSizeOutsideCalculatedCorrectly() {
        // Given
        let size = CGSize(width: 1000, height: 750)
        let aspectRatio: CGFloat = 1
        let expectedResult = CGSize(width: 1000, height: 1000)
        // When
        let result = size.sizeOutside(with: aspectRatio)
        // Then
        XCTAssertEqual(result, expectedResult)
    }
    
    func testThatSizeOutsideCannotCalculatedWithZeroAspectRatio() {
        testSizeOutsideWithAspectRatio(.zero)
    }
    
    func testThatSizeOutsideCannotCalculatedWithNanAspectRatio() {
        testSizeOutsideWithAspectRatio(.nan)
    }
    
    func testThatSizeOutsideCannotCalculatedWithInfinityAspectRatio() {
        testSizeOutsideWithAspectRatio(.infinity)
    }
    
    func testThatAspectRatioIsCalculated() {
        // Given
        let size = CGSize(width: 1920, height: 1080)
        let expectedResult = 16.0 / 9.0
        // When
        let aspectRatio = size.aspectRatio
        // Then
        XCTAssertEqual(aspectRatio, expectedResult)
    }
    
    func testThatAspectRatioIsNotCalculatedWithZeroWidth() {
        testAspectRatio(width: CGFloat.zero)
    }
    
    func testThatAspectRatioIsNotCalculatedWithNanWidth() {
        testAspectRatio(width: CGFloat.nan)
    }
    
    func testThatAspectRatioIsNotCalculatedWithInfinityWidth() {
        testAspectRatio(width: CGFloat.infinity)
    }
    
    func testThatAspectRatioIsNotCalculatedWithZeroHeight() {
        testAspectRatio(height: CGFloat.zero)
    }
    
    func testThatAspectRatioIsNotCalculatedWithNanHeight() {
        testAspectRatio(height: CGFloat.nan)
    }
    
    func testThatAspectRatioIsNotCalculatedWithInfinityHeight() {
        testAspectRatio(height: CGFloat.infinity)
    }
    
    func testThatSizeScaledCorrectly() {
        // Given
        let size = CGSize(width: 10, height: 10)
        let expected = CGSize(width: 100, height: 100)
        // When
        let result = size.scaled(scale: 10)
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testThatSizeRoundedCorrectly() {
        // Given
        let size = CGSize(width: 10.3, height: 10.7)
        let expected = CGSize(width: 10, height: 11)
        // When
        let result = size.rounded()
        // Then
        XCTAssertEqual(result, expected)
    }
    
    func testThatSizeDiagonalIsCorrect() {
        // Given
        let size = CGSize(width: 3, height: 4)
        // When
        let diagonal = size.diagonal
        // Then
        XCTAssertEqual(diagonal, 5)
    }
    
    func testThatMinSideAndMaxSideAreFound() {
        // Given
        let minimumSide = 10.3
        let maximumSide = 10.7
        let size = CGSize(width: minimumSide, height: maximumSide)
        // When
        let minResult = size.minSide
        let maxResult = size.maxSide
        // Then
        XCTAssertEqual(minResult, minimumSide)
        XCTAssertEqual(maxResult, maximumSide)
    }
    
    func testThatAbsCorrectly() {
        // Given
        let size = CGSize(width: -10, height: -5)
        // When
        let result = size.abs
        // Then
        XCTAssertTrue(result.isAlmostEqual(to: CGSize(width: 10, height: 5)))
    }
    
    // MARK: - Private methods
    private func testSizeInsideWithAspectRatio(_ aspectRatio: CGFloat) {
        // Given
        let size = CGSize(width: 640, height: 640)
        // When
        let result = size.sizeInside(with: aspectRatio)
        // Then
        XCTAssertTrue(result.width.isNaN)
        XCTAssertTrue(result.height.isNaN)
    }
    
    private func testSizeOutsideWithAspectRatio(_ aspectRatio: CGFloat) {
        // Given
        let size = CGSize(width: 1000, height: 750)
        // When
        let result = size.sizeOutside(with: aspectRatio)
        // Then
        XCTAssertTrue(result.width.isNaN)
        XCTAssertTrue(result.height.isNaN)
    }
    
    private func testAspectRatio(width: CGFloat = 1024,
                                 height: CGFloat = 768) {
        // Given
        let size = CGSize(width: width, height: height)
        // When
        let result = size.aspectRatio
        // Then
        XCTAssertTrue(result.isNaN)
    }
}
