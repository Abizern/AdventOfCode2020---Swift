import Foundation

public struct Day01 {
    let input: Set<Int>

     public init(_ input: Set<Int>) {
        self.input = input
    }

    public init() {
        self.init(Input.set(from: .urlForInput(1)))
    }
}


extension Day01 {
    func matchingFunction(sum: Int, input: Set<Int>) -> (Int) -> (Int, Int)? {
        { value in
            let target = sum - value
            guard input.contains(target) else { return nil }

            return (value, target)
        }
    }

    func matchingTripletFunction(sum: Int, input: Set<Int>) -> (Int) -> (Int, Int, Int)? {
        let array = Array(input)
        return { value in
            let target = sum - value
            guard let (x, y) = array.compactMap(matchingFunction(sum: target, input: input)).first
            else { return nil }

            return (value, x, y)
        }
    }
}


extension Day01: Problem {
    public func title() -> String {
        "--- Day 1: Report Repair ---"
    }

    public func part1() -> String {
        let array = Array(input)
        guard let (x, y) = array.compactMap(matchingFunction(sum: 2020, input: input)).first
        else { return "0" }

        return "\(x * y)"
    }

    public func part2() -> String {
        let array = Array(input)
        guard let (x, y, z) = array.compactMap(matchingTripletFunction(sum: 2020, input: input)).first
        else { return "0" }

        return "\(x * y * z)"
    }
}
