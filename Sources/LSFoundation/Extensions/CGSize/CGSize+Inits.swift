// Apple
import UIKit

public extension CGSize {
    /// Constructor for size with same sides
    /// - Parameter side: side value
    /// - Returns: new object
    static func make(with side: CGFloat) -> CGSize {
        CGSize(width: side,
               height: side)
    }
    
    /// Nan size
    static var nan: CGSize {
        CGSize(width: CGFloat.nan,
               height: CGFloat.nan)
    }
    
    /// Converts size to pixel grid
    /// - Parameter scale: Number of pixels per point. Default value is *UIScreen.main.scale*
    /// - Returns: Rounded to screen grid value
    @MainActor
    func toPixelGrid(scale: CGFloat = UIScreen.main.scale) -> CGSize {
        CGSize(width: width.toPixelGrid(scale: scale),
               height: height.toPixelGrid(scale: scale))
    }
}
