public extension Double {
    /// Converts to "hh:mm:ss"
    /// - Returns: "hh:mm:ss" or "mm:ss" when less than hour
    func timeFormat() -> String {
        let s: Int = Int(self) % 60
        let m: Int = Int(self) / 60 % 60
        let h: Int = Int(self) / 3600
        
        return h > 0 ? String(format: "%02d:%02d:%02d", h, m, s) : String(format: "%02d:%02d", m, s)
    }
}
