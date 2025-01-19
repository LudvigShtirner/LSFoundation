//
//  RestrictedStackTests.swift
//  
//
//  Created by Алексей Филиппов on 23.02.2023.
//

// Apple
import XCTest
// SPM
import LSFoundation

final class RestrictedStackTests: XCTestCase {
    // MARK: - Tests
    func testThatRestrictedStackCreatedNonEmpty() {
        // Given
        let example = Example()
        // When
        let restrictedStack = RestrictedStack(initialValue: example, maxCount: 5)
        // Then
        XCTAssertTrue(restrictedStack.storage.count == 1)
        XCTAssertFalse(restrictedStack.hasPreviousState)
        XCTAssertFalse(restrictedStack.hasNextState)
    }
    
    func testThatRestrictedStackCreatedEmpty() {
        // Given
        // When
        let restrictedStack = RestrictedStack<Example>(initialValue: nil, maxCount: 5)
        // Then
        XCTAssertTrue(restrictedStack.storage.count == 0)
        XCTAssertFalse(restrictedStack.hasPreviousState)
        XCTAssertFalse(restrictedStack.hasNextState)
    }
    
    func testThatRestrictedStackCreatedWithArrayCorrectly() {
        // Given
        let array = [Example(), Example(), Example()]
        // When
        let restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        // Then
        XCTAssertTrue(restrictedStack.storage.count == array.count)
        XCTAssertTrue(restrictedStack.hasPreviousState)
        XCTAssertFalse(restrictedStack.hasNextState)
    }
    
    func testThatRestrictedStackDoesNotObtainPreviousState() {
        // Given
        var restrictedStack = RestrictedStack<Example>(initialValue: nil, maxCount: 5)
        // When
        let previousState = restrictedStack.obtainPreviousState()
        // Then
        XCTAssertNil(previousState)
    }
    
    func testThatRestrictedStackObtainPreviousState() {
        // Given
        let ex = Example()
        let array = [Example(), Example(), ex, Example()]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        // When
        let previousState = restrictedStack.obtainPreviousState()
        // Then
        XCTAssertNotNil(previousState)
        XCTAssertEqual(ex.identifier, previousState?.identifier)
    }
    
    func testThatRestrictedStackObtainNextState() {
        // Given
        let ex = Example()
        let array = [Example(), Example(), Example(), ex]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        _ = restrictedStack.obtainPreviousState()
        // When
        let nextState = restrictedStack.obtainNextState()
        // Then
        XCTAssertNotNil(nextState)
        XCTAssertEqual(ex.identifier, nextState?.identifier)
    }
    
    func testThatRestrictedStackDoesNotObtainNextState() {
        // Given
        let array = [Example(), Example(), Example(), Example()]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        // When
        let nextState = restrictedStack.obtainNextState()
        // Then
        XCTAssertNil(nextState)
    }
    
    func testThatRestrictedStackAddStateClearsRedoActions() {
        // Given
        let array = [Example(), Example(), Example(), Example()]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        _ = restrictedStack.obtainPreviousState()
        _ = restrictedStack.obtainPreviousState()
        // When
        XCTAssertTrue(restrictedStack.hasNextState)
        restrictedStack.addState(Example())
        // Then
        XCTAssertFalse(restrictedStack.hasNextState)
    }
    
    func testThatRestrictedStackAddStateRemovesFirst() {
        // Given
        let array = [Example(), Example(), Example(), Example(), Example()]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        let count = restrictedStack.storage.count
        // When
        restrictedStack.addState(Example())
        // Then
        XCTAssertEqual(count, restrictedStack.storage.count)
    }
    
    func testThatRestrictedStackRemoveAllStatesClearsAll() {
        // Given
        let array = [Example(), Example(), Example(), Example(), Example()]
        var restrictedStack = RestrictedStack(stored: array, maxCount: 5)
        // When
        restrictedStack.removeAllStates()
        // Then
        XCTAssertEqual(0, restrictedStack.storage.count)
    }
    
    // MARK: - Subtypes
    struct Example {
        let identifier = UUID().uuidString
    }
}
