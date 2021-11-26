import Foundation
import Algorithms

private extension Character {
    var binaryDigit: Character {
        switch self {
        case "F", "L":
            return "0"
        default:
            return "1"
        }
    }
}

public struct Day05 {
    let passes: [Int]

    public init(_ passes: [String]) {
        self.passes = passes.compactMap { string in
            Int(String(string.map(\.binaryDigit)), radix: 2)
        }
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(5)))
    }
}


extension Day05: Problem {
    public func title() -> String {
        "--- Day 5: Binary Boarding ---"
    }

    public func part1() -> String {
        passes.max().flatMap(String.init) ?? "No solution found"
    }

    public func part2() -> String {
        let seatId = passes
            .sorted()
            .slidingWindows(ofCount: 2)
            .filter { slice -> Bool in
                guard case let (first?, second?) = (slice.first, slice.last)
                else { return false }
                return second - first == 2
            }
            .first
            .flatMap { ($0.last ?? 0) - 1 }

        return seatId.flatMap(String.init) ?? "No solution found"
    }
    
}
