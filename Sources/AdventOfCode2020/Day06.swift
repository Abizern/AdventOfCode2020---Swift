import Foundation

extension Array where Element == String {
    /// The number of unique characters in all  the elementns
    var countOr: Int {
        self.map(Set.init)
            .reduce(into: Set<String.Element>()) { accum, set in
                accum = accum.union(set)
            }
            .count
    }

    /// The number of unique characters that are common to all the elements
    var countAnd: Int {
        self.map(Set.init)
            .reduce(into: Set("abcdefghijklmnopqrstuvwxyz")) { accum, set in
                accum = accum.intersection(set)
            }
            .count
    }
}

public struct Day06 {
    let input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.newLines(from: .urlForInput(6)))
    }
}


extension Day06: Problem {
    public func title() -> String {
        "--- Day 6: Custom Customs ---"
    }

    public func part1() -> String {
        String(input
            .map { $0.components(separatedBy: .whitespacesAndNewlines) }
            .map(\.countOr)
            .reduce(0, +))
    }

    public func part2() -> String {
        String(input
                .map { $0.components(separatedBy: .whitespacesAndNewlines) }
                .map(\.countAnd)
                .reduce(0, +))
    }
}
