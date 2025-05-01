public extension String {
    /// Renamed count property
    var length: Int {
        return count
    }
    
    /// Obtain character from string by index
    subscript (index: Int) -> String? {
        if index >= length {
            return nil
        }
        return self[index ..< index + 1]
    }
    
    /// Create substring from index to end
    /// - Parameter fromIndex: substring's start index
    /// - Returns: substring of string from index
    func substring(fromIndex: Int) -> String {
        if length == 0 {
            return ""
        }
        return self[min(fromIndex, length) ..< length]
    }
    
    /// Create substring from start to index
    /// - Parameter toIndex: substring's end index
    /// - Returns: substring of string to index
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, min(length, toIndex))]
    }
    
    /// Obtain characters in range
    subscript (range: Range<Int>) -> String {
        let lowerValue = range.lowerBound.inRange(min: .zero, max: length)
        let upperValue = range.upperBound.inRange(min: .zero, max: length)
        let closedRange = lowerValue ..< upperValue
        let start = index(startIndex, offsetBy: closedRange.lowerBound)
        let end = index(start, offsetBy: closedRange.upperBound - closedRange.lowerBound)
        return String(self[start ..< end])
    }
}
