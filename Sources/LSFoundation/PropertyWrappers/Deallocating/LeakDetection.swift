import Foundation

public enum LeakDetection {
    public static func expectDeallocation(_ object: AnyObject & Sendable, in timeInterval: TimeInterval = 1) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) { [weak object] in
            if let object {
                assertionFailure("Expected deallocation of \(object)")
            }
        }
    }
}
