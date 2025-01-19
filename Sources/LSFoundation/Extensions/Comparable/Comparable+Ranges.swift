// Apple
import Foundation

public extension Comparable {
    func moreOrEqual(_ min: Self) -> Self {
        max(self, min)
    }
    
    func lessOrEqual(_ max: Self) -> Self {
        min(self, max)
    }
    
    func inRange(min: Self, max: Self) -> Self {
        self.lessOrEqual(max).moreOrEqual(min)
    }
}
