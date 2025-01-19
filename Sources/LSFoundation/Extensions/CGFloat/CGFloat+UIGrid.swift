// Apple
import UIKit

@MainActor
public extension CGFloat {
    /// Rounded to scale grid
    ///
    /// Use method to avoid color blending in pixels
    /// - Parameter scale: Number of pixels per point. Default value is *UIScreen.main.scale*
    /// - Returns: Rounded to screen grid value
    func toPixelGrid(scale: CGFloat = UIScreen.main.scale) -> CGFloat {
        let pixels = self * scale
        let rounded = pixels.rounded()
        return rounded / scale
    }
    
    /// Calculated pixel size based on Screen scale
    static var pixelSize: CGFloat { 1.0 / UIScreen.main.scale }
}
