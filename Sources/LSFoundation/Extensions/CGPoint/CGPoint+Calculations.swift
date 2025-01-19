// Apple
import CoreGraphics

public extension CGPoint {
    /// Finds line length between current and passed point
    /// - Parameter point: Reach point
    /// - Returns: Distance between points
    func distance(to point: CGPoint) -> CGFloat {
        let diffX = point.x - self.x
        let diffY = point.y - self.y
        return (pow(diffX, 2) + pow(diffY, 2)).squareRoot()
    }
}
