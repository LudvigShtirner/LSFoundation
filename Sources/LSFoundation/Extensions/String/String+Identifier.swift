import Foundation

public extension String {
    static var uniqueIdentifier: String {
        ProcessInfo.processInfo.globallyUniqueString
    }
}
