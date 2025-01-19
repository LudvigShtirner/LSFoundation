// Apple
import UIKit

public extension CGPoint {
    /// Correct method for point comparison
    /// - Parameter other: other point
    /// - Returns: true if equal with minimum diff
    func isAlmostEqual(to other: CGPoint) -> Bool {
        x.isAlmostEqual(to: other.x) 
        && y.isAlmostEqual(to: other.y)
    }
    
    /// Correct method for point comparison
    /// - Parameters:
    ///   - other: other point
    ///   - tolerance: maximum tolerance volume
    /// - Returns: true if equal with passed diff
    func isAlmostEqual(to other: CGPoint, tolerance: CGFloat) -> Bool {
        x.isAlmostEqual(to: other.x, tolerance: tolerance)
        && y.isAlmostEqual(to: other.y, tolerance: tolerance)
    }
    
    /// Converts Point to pixel grid
    /// - Parameter scale: Number of pixels per point. Default value is *UIScreen.main.scale*
    /// - Returns: Rounded to screen grid value
    @MainActor
    func toPixelGrid(scale: CGFloat = UIScreen.main.scale) -> CGPoint {
        CGPoint(x: x.toPixelGrid(scale: scale),
                y: y.toPixelGrid(scale: scale))
    }
}
