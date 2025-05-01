public extension Result where Success == Void {
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
