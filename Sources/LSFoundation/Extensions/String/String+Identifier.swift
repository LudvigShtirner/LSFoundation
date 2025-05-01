public extension String {
    static var uniqueIdentifier: String {
        ProcessInfo.processInfo.globallyUniqueString + UUID().uuidString
    }
}
