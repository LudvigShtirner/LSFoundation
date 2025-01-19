// Apple
import CoreGraphics

public extension CGRect {
    var minSide: CGFloat {
        size.minSide
    }
    
    var diagonal: CGFloat {
        topLeftPoint.distance(to: bottomRightPoint)
    }
    
    var topLeftPoint: CGPoint {
        origin
    }
    
    var topRightPoint: CGPoint {
        CGPoint(x: maxX, y: minY)
    }
    
    var bottomLeftPoint: CGPoint {
        CGPoint(x: minX, y: maxY)
    }
    
    var bottomRightPoint: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
    
    var topCenter: CGPoint {
        CGPoint(x: midX, y: minY)
    }
    
    var leftCenter: CGPoint {
        CGPoint(x: minX, y: midY)
    }
    
    var bottomCenter: CGPoint {
        CGPoint(x: midX, y: maxY)
    }
    
    var rightCenter: CGPoint {
        CGPoint(x: maxX, y: midY)
    }
    
    var center: CGPoint {
        get { CGPoint(x: midX, y: midY) }
        set {
            origin = CGPoint(x: newValue.x - width.half,
                             y: newValue.y - height.half)
        }
    }
}
