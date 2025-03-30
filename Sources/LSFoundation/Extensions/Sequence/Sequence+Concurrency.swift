import Foundation

public typealias TransformClosure<Element, Result> = (Element) async -> Result

public extension Sequence {
    func concurrentMap<T: Sendable>(withPriority priority: TaskPriority? = nil,
                                    _ transform: @escaping TransformClosure<Element, T>) async -> [T] {
        let tasks: [Task<T, Never>] = map { element in
            let closure = UncheckedCompletion {
                await transform(element)
            }
            return Task(priority: priority) {
                await closure.block()
            }
        }
        return await tasks.asyncMap { task in
            await task.value
        }
    }
    
    func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
        var values = [T]()
        for element in self {
            try await values.append(transform(element))
        }
        return values
    }
}

struct UncheckedCompletion<U>: @unchecked Sendable {
    typealias Block = () async -> U
    
    let block: Block
    
    init(_ block: @escaping Block) {
        self.block = block
    }
}
