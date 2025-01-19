// Apple
import Foundation

public extension CGRect {
    func isAlmostEqual(to other: CGRect) -> Bool {
        size.isAlmostEqual(to: other.size) 
        && origin.isAlmostEqual(to: other.origin)
    }
    
    func isAlmostEqual(to other: CGRect,
                       error: CGFloat) -> Bool {
        size.isAlmostEqual(to: other.size,
                           tolerance: error)
        && origin.isAlmostEqual(to: other.origin,
                                tolerance: error)
    }
}
