// Apple
import Foundation

/// Container with weak value
public final class WeakBox<T: AnyObject> {
    // MARK: - Data
    public weak var unbox: T?
    
    // MARK: - Inits
    public init(_ value: T) {
        unbox = value
    }
}
