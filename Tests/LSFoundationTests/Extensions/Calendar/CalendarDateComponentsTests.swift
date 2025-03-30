// SPM
import LSFoundation
// Apple
import XCTest

final class CalendarDateComponentsTests: XCTestCase {
    // MARK: - Tests
    func test_calendar_getYear_returnsCorrect() {
        // Given
        let calendar = Calendar.current
        let date = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: 2023
        ).date
        // When
        let year = calendar.getYear(from: date)
        // Then
        XCTAssertEqual(year, 2023)
    }
    
    func test_calendar_getYear_returnsCurrentCorrect() {
        // Given
        let calendar = Calendar.current
        // When
        let year = calendar.getYear()
        // Then
        let components = calendar.dateComponents([.year], from: .now)
        XCTAssertEqual(year, components.year)
    }
    
    func test_calendar_getMonth_returnsCorrect() {
        // Given
        let calendar = Calendar.current
        let date = DateComponents(
            calendar: calendar,
            timeZone: .current,
            month: 7
        ).date
        // When
        let month = calendar.getMonth(from: date)
        // Then
        XCTAssertEqual(month, 7)
    }
    
    func test_calendar_getWeekOfYear_returnsCorrect() {
        // Given
        let calendar = Calendar.current
        let date = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: 2023,
            weekday: 1,
            weekOfYear: 22
        ).date
        // When
        let weekOfYear = calendar.getWeekOfYear(from: date)
        // Then
        XCTAssertEqual(weekOfYear, 22)
    }
    
    func test_calendar_getDayOfYear_returnsCorrect() {
        // Given
        let calendar = Calendar.current
        let date = DateComponents(
            calendar: calendar,
            timeZone: .current,
            year: 2023,
            month: 12,
            day: 1
        ).date
        // When
        let dayOfYear = calendar.getDayOfYear(from: date)
        // Then
        XCTAssertEqual(dayOfYear, 335)
    }
    
    func test_calendar_getDayOfYear_returnsCurrentCorrect() {
        // Given
        let calendar = Calendar.current
        // When
        let dayOfYear = calendar.getDayOfYear()
        // Then
        let components = calendar.ordinality(of: .day, in: .year, for: .now)
        XCTAssertEqual(dayOfYear, components)
    }
}
