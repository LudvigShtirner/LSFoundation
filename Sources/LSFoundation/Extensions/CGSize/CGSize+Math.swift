// Apple
import CoreGraphics

public extension CGSize {
    func sizeInside(with aspectRatio: CGFloat) -> CGSize {
        if !aspectRatio.isNormal {
            return CGSize.nan
        }
        let insideWidth = min(height * aspectRatio, width)
        let insideHeight = min(width / aspectRatio, height)
        return CGSize(width: insideWidth,
                      height: insideHeight)
    }
    
    func sizeOutside(with aspectRatio: CGFloat) -> CGSize {
        if !aspectRatio.isNormal {
            return CGSize.nan
        }
        let outsideWidth = max(height * aspectRatio, width)
        let outsideHeight = max(width / aspectRatio, height)
        return CGSize(width: outsideWidth,
                      height: outsideHeight)
    }
    
    var aspectRatio: CGFloat {
        if !width.isNormal {  return CGFloat.nan }
        if !height.isNormal { return CGFloat.nan }
        return width / height
    }
    
    var diagonal: CGFloat {
        CGPoint.zero.distance(to: CGPoint(x: width, y: height))
    }
    
    func scaled(scale: CGFloat) -> CGSize {
        return CGSize(width: width * scale,
                      height: height * scale)
    }
    
    var minSide: CGFloat { min(width, height) }
    var maxSide: CGFloat { max(width, height) }
    
    func rounded() -> CGSize {
        CGSize(width: round(width),
               height: round(height))
    }
    
    var abs: CGSize {
        CGSize(width: Swift.abs(width),
               height: Swift.abs(height))
    }
}
