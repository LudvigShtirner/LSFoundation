@propertyWrapper
public final class ObservableValue<ValueType: Sendable>: Sendable {
    // MARK: - Data
    private let state: ObservableState<ValueType>
    nonisolated(unsafe) private var __value: ValueType
    
    // MARK: - Inits
    public init(value: ValueType) {
        self.state = ObservableState(value: value)
        self.__value = value
    }
    
    // MARK:
    public var wrappedValue: ValueType {
        get {
            __value
        }
        set {
            Task {
                await state.updateValue(newValue)
                __value = newValue
                notify()
            }
        }
    }
    
    public func addSubscriber(
        _ subscriber: AnyObject & Sendable,
        notifyOnSubscribe: Bool = true,
        block: @Sendable @escaping (ValueType) -> Void
    ) {
        Task {
            await state.addSubscriber(
                subscriber,
                notifyOnSubscribe: notifyOnSubscribe,
                block: block
            )
        }
    }
    
    public func removeSubscriber(_ subscriber: AnyObject & Sendable) {
        Task {
            await state.removeSubscriber(subscriber)
        }
    }
    
    public func removeAllSubscribers() {
        Task {
            await state.removeAllSubscribers()
        }
    }
    
    private func notify() {
        Task {
            let (subscribers, value) = await state.getSubscribersAndValue()
            subscribers.forEach {
                $0.notifyBlock(value)
            }
        }
    }
}

private actor ObservableState<ValueType> {
    var value: ValueType
    private var subscribers: [Subscription<ValueType>] = []
    
    init(value: ValueType) {
        self.value = value
    }
    
    func updateValue(_ value: ValueType) {
        self.value = value
    }
    
    func addSubscriber(
        _ subscriber: AnyObject,
        notifyOnSubscribe: Bool,
        block: @Sendable @escaping (ValueType) -> Void
    ) {
        let subscription = Subscription(
            subscriber: subscriber,
            block: block
        )
        subscribers.append(subscription)
        if notifyOnSubscribe {
            block(value)
        }
    }
    
    func removeSubscriber(_ subscriber: AnyObject) {
        subscribers.removeAll { $0.subscriber === subscriber }
    }
    
    func removeAllSubscribers() {
        subscribers = []
    }
    
    func getSubscribersAndValue() -> ([Subscription<ValueType>], ValueType) {
        subscribers.removeAll(where: { $0.isInvalid })
        return (subscribers, value)
    }
}

private struct Subscription<ValueType>: Sendable {
    nonisolated(unsafe) weak var subscriber: AnyObject?
    let notifyBlock: @Sendable (ValueType) -> Void
    
    init(
        subscriber: AnyObject,
        block: @Sendable @escaping (ValueType) -> Void
    ) {
        self.subscriber = subscriber
        self.notifyBlock = block
    }
    
    var isInvalid: Bool { subscriber == nil }
}
