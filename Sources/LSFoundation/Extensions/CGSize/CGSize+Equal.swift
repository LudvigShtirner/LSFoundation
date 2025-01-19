// Apple
import Foundation

public extension CGSize {
    /// Correct method for size comparison
    /// - Parameter other: other size
    /// - Returns: true if equal with minimum diff
    func isAlmostEqual(to other: CGSize) -> Bool {
        width.isAlmostEqual(to: other.width)
        && height.isAlmostEqual(to: other.height)
    }
    
    /// Correct method for size comparison
    /// - Parameters:
    ///   - other: other size
    ///   - tolerance: maximum tolerance volume
    /// - Returns: true if equal with minimum diff
    func isAlmostEqual(to other: CGSize,
                       tolerance: CGFloat) -> Bool {
        width.isAlmostEqual(to: other.width, tolerance: tolerance)
        && height.isAlmostEqual(to: other.height, tolerance: tolerance)
    }
}
