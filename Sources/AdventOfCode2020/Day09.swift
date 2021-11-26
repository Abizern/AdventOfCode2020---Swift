import Foundation
import Algorithms

public struct Day09 {
    let input: [Int]

    public init(_ input: [Int]) {
        self.input = input
    }

    public init() {
        self.init(Input.ints(from: .urlForInput(9)))
    }

    public func solve1(length: Int) -> Int? {
        input.slidingWindows(ofCount: length + 1)
            .lazy
            .compactMap(invalidLastNumberIn)
            .first
    }

    public func solve2(length: Int) -> Int {
        guard let target = solve1(length: length) else {
            fatalError()
        }
        let list = elementsSummingTo(target)

        return list.min()! + list.max()!
    }

    func elementsSummingTo(_ target: Int) -> [Int] {
        let length = input.count
        var start = 0
        var end = 1

        var found = false

        repeat {
            let window = input[start...end]
            assert(!window.contains(target))

            let sum = window.reduce(0, +)
            switch sum{
            case _ where sum < target:
                end += 1
            case _ where sum > target:
                start += 1
            default:
                found = true
            }
        } while !found && end < length


        return Array(input[start...end])
    }

    func invalidLastNumberIn(_ slice: ArraySlice<Int>) -> Int? {
        guard let target = slice.last else { return nil }
        var window = slice.dropLast().sorted()[...]

        var shouldContinue = true
        var isValid = false

        repeat {
            if let first = window.first, let second = window.last {
                let test = target - (first + second)
                switch test {
                case _ where test > 0:
                    window = window.dropFirst()
                case _ where test < 0:
                    window = window.dropLast()
                default:
                    isValid = true
                    shouldContinue = false
                }
            } else {
                shouldContinue = false
            }
        } while shouldContinue

        return isValid ? nil : target
    }
}


extension Day09: Problem {
    public func title() -> String {
        "--- Day 9: Encoding Error ---"
    }

    public func part1() -> String {
        guard let x = solve1(length: 25) else {
            return "Unable to solve"
        }
        return String(x)
    }

    public func part2() -> String {
        String(solve2(length: 25))
    }
}
