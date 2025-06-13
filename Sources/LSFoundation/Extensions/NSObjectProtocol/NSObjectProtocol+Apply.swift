extension NSObjectProtocol {
    @discardableResult
    public func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}
