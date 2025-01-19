// Apple
import Foundation

public extension DateFormatter {
    // MARK: - Inits
    static let shared = DateFormatter()
    
    func makeMonthString(from date: Date) -> String {
        dateFormat = "LLLL"
        return string(from: date)
    }
}
