extension NSObjectProtocol {
    @discardableResult
    public func apply(_ closure: @escaping (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
