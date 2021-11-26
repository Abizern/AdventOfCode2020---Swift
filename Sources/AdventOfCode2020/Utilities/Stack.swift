import Foundation

public struct Stack<T> {
    private var array: [T]

    public init() {
        array = [T]()
    }

    public mutating func push(_ value: T) {
        array.append(value)
    }

    @discardableResult
    public mutating func pop() -> T? {
        array.popLast()
    }

    public var peek: T? {
        array.last
    }

    public var isEmpty: Bool {
        array.isEmpty
    }
}
