/// Mirror provider model
open class MirrorObject {
    // MARK: - Data
    let mirror: Mirror
    
    // MARK: - Inits
    public init(reflecting: Any) {
        mirror = Mirror(reflecting: reflecting)
    }
    
    // MARK: - Interface methods
    /// Obtain data from object
    /// - Parameter variableName: Name of class field
    /// - Returns: Value from found class field
    open func extract<T>(variableName: StaticString = #function) -> T? {
        extract(variableName: variableName, mirror: mirror)
    }
}

private extension MirrorObject {
    func extract<T>(variableName: StaticString,
                    mirror: Mirror?) -> T? {
        guard let mirror else { return nil }
        if let descendant = mirror.descendant("\(variableName)") as? T {
            return descendant
        }
        return extract(variableName: variableName,
                       mirror: mirror.superclassMirror)
    }
}
