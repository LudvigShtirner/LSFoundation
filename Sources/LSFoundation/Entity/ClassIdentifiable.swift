/// Provides easy way to obtain className for all NSObject inheritors
public protocol ClassIdentifiable {
    static var className: String { get }
}

public extension ClassIdentifiable {
    static var className: String {
        String(describing: self)
    }
}

extension NSObject: ClassIdentifiable { }
