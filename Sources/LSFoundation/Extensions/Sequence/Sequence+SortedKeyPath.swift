// Apple
import Foundation

public extension Sequence {
    /// Сортирует элементы используя KeyPath
    /// - Parameter keyPath: keyPath по которому необходимо отсортировать элементы
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { lhs, rhs in
            return lhs[keyPath: keyPath] < rhs[keyPath: keyPath]
        }
    }
}
