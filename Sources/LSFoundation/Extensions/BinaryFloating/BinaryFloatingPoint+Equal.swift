public extension BinaryFloatingPoint {
    /// Correct method for float comparison
    /// - Parameter other: value to compare
    /// - Returns: true if equal
    func isAlmostEqual(to other: Self) -> Bool {
        abs(self - other) < .ulpOfOne
    }
    
    /// Correct method for float comparison
    /// - Parameters:
    ///   - other: value to compare
    ///   - tolerance: tolerance volume
    /// - Returns: true if equal
    func isAlmostEqual(to other: Self, tolerance: Self) -> Bool {
        abs(self - other) <= tolerance
    }
    
    /// Value that less by minimum float diff
    @inlinable
    var nearestLower: Self {
        self - .ulpOfOne
    }
}
