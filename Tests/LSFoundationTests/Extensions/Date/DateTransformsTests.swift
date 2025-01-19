//
//  DateTransformsTests.swift
//  
//
//  Created by Алексей Филиппов on 05.08.2022.
//

// Apple
import XCTest

final class DateTransformsTests: XCTestCase {
    // MARK: - Tests
    func testThatStartOfDayCreated() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        let result = sut.createWithFirstSecondsOfDay()
        // Then
        let components = environment.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: result)
        XCTAssertEqual(components.year, environment.year)
        XCTAssertEqual(components.month, environment.month)
        XCTAssertEqual(components.day, environment.day)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
    
    func testThatLastSecondsOfDayCreated() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        let result = sut.createWithLastSecondsOfDay()
        // Then
        XCTAssertNotNil(result)
        let components = environment.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: result!)
        XCTAssertEqual(components.year, environment.year)
        XCTAssertEqual(components.month, environment.month)
        XCTAssertEqual(components.day, environment.day)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }
    
    func testThatFirstDayOfMonthCreated() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        let result = sut.createWithFirstDayOfMonth()
        // Then
        XCTAssertNotNil(result)
        let components = environment.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: result!)
        XCTAssertEqual(components.year, environment.year)
        XCTAssertEqual(components.month, environment.month)
        XCTAssertEqual(components.day, 1)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }
    
    func testThatLastDayOfMonthCreated() {
        // Given
        let environment = Environment()
        let sut = environment.makeSut()
        // When
        let result = sut.createWithLastDayOfMonth()
        // Then
        XCTAssertNotNil(result)
        let components = environment.calendar.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: result!)
        XCTAssertEqual(components.year, environment.year)
        XCTAssertEqual(components.month, environment.month)
        XCTAssertEqual(components.day, 31)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }
}

private final class Environment {
    var year = 2022
    var month = 8
    var day = 5
    
    var calendar = Calendar.current
    
    func makeSut() -> Date {
        let components = DateComponents(calendar: calendar,
                                        timeZone: .current,
                                        year: year,
                                        month: month,
                                        day: day,
                                        hour: 14,
                                        minute: 27,
                                        second: 58)
        return calendar.date(from: components)!
    }
}
