public extension Calendar {
    /// Extract year from date
    /// - Parameter date: Direct date
    /// - Returns: Year from date. If date not passed, then used current date
    func getYear(from date: Date? = nil) -> Int {
        getComponent(.year, from: date)
    }
    
    /// Extract month from date
    /// - Parameter date: Direct date
    /// - Returns: Month from date. If date not passed, then used current date
    func getMonth(from date: Date? = nil) -> Int {
        getComponent(.month, from: date)
    }
    
    /// Extract week from date
    /// - Parameter date: Direct date
    /// - Returns: Week from date. If date not passed, then used current date
    func getWeekOfYear(from date: Date? = nil) -> Int {
        getComponent(.weekOfYear, from: date)
    }
    
    /// Extract day from date
    /// - Parameter date: Direct date
    /// - Returns: Day from date. If date not passed, then used current date
    func getDayOfYear(from date: Date? = nil) -> Int? {
        let d = date ?? Date()
        return ordinality(of: .day, in: .year, for: d)
    }
    
    private func getComponent(_ dateComponent: Calendar.Component,
                              from date: Date?) -> Int {
        let d = date ?? Date()
        return component(dateComponent, from: d)
    }
}
