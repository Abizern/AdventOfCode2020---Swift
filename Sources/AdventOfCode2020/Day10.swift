import Foundation
import Algorithms

public struct Day10 {
    let input: [Int]

    public init(_ input: [String]) {
        let ints = input
            .compactMap(Int.init)
            .sorted()
        self.input = [0] + ints + [ints.last! + 3]
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(10)))
    }

    func combinations(_ input: ArraySlice<Int>) -> Int {
        let first = input.startIndex
        let second = first + 1
        let third =  first + 2
        switch (input[first], input[second], input[third]) {
        case (1, 1, 1):
            return 3
        case (1, 1, _):
            return 1
        default:
            return 0
        }
    }

    func dynamic(_ input: [Int]) -> Int {
        let memo = Set(input)
        let maxValue = memo.max()!
        var paths = Dictionary<Int, Int>(minimumCapacity: maxValue)
        paths[0] = 1

        (1...maxValue).forEach { i in
            guard memo.contains(i) else { return }
            paths[i] = paths[i - 1, default: 0] + paths[i - 2, default: 0] + paths[i - 3, default: 0]
        }
        return paths[maxValue, default: 0]
    }
}


extension Day10: Problem {
    public func title() -> String {
        "--- Day 10: Adapter Array ---"
    }

    public func part1() -> String {
        let differences = input.slidingWindows(ofCount: 2).map { slice in
            slice.last! - slice.first!
        }
        return String(((differences.filter { $0 == 3 }.count) * differences.filter { $0 == 1 }.count))
    }

    public func part2() -> String {
        String(input
                .slidingWindows(ofCount: 2).map { $0.last! - $0.first! }
                .slidingWindows(ofCount: 3)
                .map(combinations)
                .partialSums
                .map { max($0, 2) }
                .reduce(1, *))
    }

    public func part2Dynamic() -> Int {
        dynamic(input)
    }
}

extension Array where Element == Int {
    var partialSums: [Int] {
        let partials = reduce(into: ([Int](), 0)) { (accum, newValue) in
            let sum = accum.1

            switch (sum, newValue) {
            case (0, 0):
                break
            case (0, let x) where x != 0:
                accum.1 = x
            case let (x, y) where x != 0 && y != 0:
                accum.1 = x + y
            case (let x, 0) where x != 0:
                accum.0.append(x)
                accum.1 = 0
            default:
                break
            }
        }

        var result = partials.0
        if partials.1 != 0 {
            result.append(partials.1)
        }

        return result
    }
}
