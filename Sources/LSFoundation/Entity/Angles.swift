// Apple
import CoreGraphics

/// Wrapper about CGFloat to handle degrees
public struct Degrees {
    public let value: CGFloat
    
    public init(_ value: CGFloat) {
        self.value = value
    }
    
    /// Converts current value to Radians
    public var radians: Radians {
        Radians(value * CGFloat.pi / 180.0)
    }
}

/// Wrapper about CGFloat to handle radians
public struct Radians {
    public let value: CGFloat
    
    public init(_ value: CGFloat) {
        self.value = value
    }
    
    /// Converts current value to Degrees
    public var degrees: Degrees {
        Degrees(value * 180.0 / CGFloat.pi)
    }
}
