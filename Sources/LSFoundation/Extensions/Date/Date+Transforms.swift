public extension Date {
    func createWithFirstSecondsOfDay(calendar: Calendar = .current) -> Date {
        calendar.startOfDay(for: self)
    }
    
    func createWithLastSecondsOfDay(calendar: Calendar = .current) -> Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let startOfDay = createWithFirstSecondsOfDay(calendar: calendar)
        return calendar.date(byAdding: components, to: startOfDay)
    }
    
    func createWithFirstDayOfMonth(calendar: Calendar = .current) -> Date? {
        let components = calendar.dateComponents([Calendar.Component.year, Calendar.Component.month], from: self)
        return calendar.date(from: components)
    }
    
    func createWithLastDayOfMonth(calendar: Calendar = .current) -> Date? {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return createWithFirstDayOfMonth(calendar: calendar).flatMap {
            calendar.date(byAdding: components,
                          to: $0)
        }
    }
    
    func monthIndex(calendar: Calendar = .current) -> Int {
        calendar.component(.month, from: self)
    }
}
