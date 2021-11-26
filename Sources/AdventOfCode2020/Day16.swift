import Foundation
import Algorithms

public struct Day16 {
    let rules: [Rule]
    let mine: [Int]
    let nearby: [[Int]]

    public init(_ input: [String]) {
        self.rules = input[0]
            .components(separatedBy: .newlines)
            .map { $0.capturedGroups(regex: ruleRegex) }
            .map { groups in
                Rule(name: groups[0], r1Start: Int(groups[1])!, r1End: Int(groups[2])!, r2Start: Int(groups[3])!, r2End: Int(groups[4])!)
            }
        self.mine = input[1]
            .components(separatedBy: .newlines)[1]
            .components(separatedBy: ",")
            .compactMap(Int.init)
        self.nearby = input[2]
            .components(separatedBy: .newlines)
            .dropFirst()
            .map { string in
                string.components(separatedBy: ",").compactMap(Int.init)
            }
    }

    public init() {
        self.init(Input.newLines(from: .urlForInput(16)))
    }
}

extension Day16 {
    func validFor(_ rules: [Rule]) -> (Int) -> Bool {
        { n in
            var isValid = false
            for rule in rules {
                if rule.isValid(n) {
                    isValid = true
                    break
                }
            }

            return isValid
        }
    }

    var invalidNumbers: [Int] {
        let validator = validFor(rules)
        return nearby
            .flatMap { $0 }
            .filter { number in
                validator(number) != true
            }
    }

    var validNearby: [[Int]] {
        let invalid = invalidNumbers
        let valid = nearby.filter { numbers -> Bool in
            var valid = true
            for number in numbers {
                if invalid.contains(number) {
                    valid = false
                    break
                }
            }

            return valid
        }

        return valid
    }
}


extension Day16: Problem {
    public func title() -> String {
        "--- Day 16: Ticket Translation ---"
    }

    public func part1() -> String {
        String(invalidNumbers.reduce(0, +))
    }

    public func part2() -> String {
        var colDict = [Int: Set<Int>]()
        let transposed = transpose(validNearby)
        transposed.enumerated().forEach { item in
            var validSet = Set<Int>()
            let index = item.offset
            let column = item.element
            rules.enumerated().forEach { ruleItem in
                let ruleIndex = ruleItem.offset
                if ruleItem.element.validate(column) {
                    validSet.insert(ruleIndex)
                }
            }

            colDict[index] = validSet
        }

        // since the rules we are interested in have indexes (0 ..< 6)
        return String(possibilitySolver(colDict)
                .filter { item in
                    (0 ..< 6).contains(item.value)
                }
                .keys
                .map { mine[$0] }
                .reduce(1, *))
    }
}

let ruleRegex = "(\\w+): (\\d+)-(\\d+) or (\\d+)-(\\d+)"

struct Rule {
    let name: String
    let firstRange: ClosedRange<Int>
    let secondRange: ClosedRange<Int>

    init(name: String, r1Start: Int, r1End: Int, r2Start: Int, r2End: Int) {
        self.name = name
        firstRange = (r1Start ... r1End)
        secondRange = (r2Start ... r2End)
    }

    func isValid(_ number: Int) -> Bool {
        firstRange ~= number || secondRange ~= number
    }

    func validate(_ numbers: [Int]) -> Bool {
        var isValid = true
        for number in numbers {
            if !self.isValid(number) {
                isValid = false
                break
            }
        }
        return isValid
    }
}

private func transpose<T>(_ array: [[T]]) -> [[T]] {
    var result = [[T]]()
    for i in (0 ..< array[0].count) {
        var line = [T]()
        for j in (0 ..< array.count) {
            line.append(array[j][i])
        }
        result.append(line)
    }
    return result
}
