import Foundation

public struct Day13 {
    let input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(13)))
    }
}


extension Day13: Problem {
    public func title() -> String {
        "--- Day 13: Shuttle Search ---"
    }

    public func part1() -> String {
        let target = Int(input[0])!
        let (busId, time) = input[1]
            .components(separatedBy: ",")
            .filter { $0 != "x" }
            .compactMap(Int.init)
            .map { ($0, ((target / $0) + 1) * $0) }
            .sorted { $0.1 < $1.1 }
            .first!

        let solution = busId * (time - target)
        return String(solution)
    }

}
