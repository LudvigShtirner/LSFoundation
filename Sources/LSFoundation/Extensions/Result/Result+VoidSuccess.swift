// Apple
import Foundation

/// Расширение для улучшения читаемости Result с типом успеха Void
public extension Result where Success == Void {
    /// Успех без возвращаемого значения
    static var success: Result {
        return Result.success(())
    }
}

public extension Result {
    var value: Success? {
        switch self {
        case .success(let value): return value
        case .failure: return nil
        }
    }
}
