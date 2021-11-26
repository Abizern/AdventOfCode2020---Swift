import Foundation

public struct Day23 {
    let input: [Int]

    public init(_ input: String) {
        self.input = input.compactMap { Int(String($0)) }
    }

    public init() {
        self.init(Input.string(from: .urlForInput(23)))
    }
}

extension Day23 {
    func cycle(_ cups: [Int]) -> [Int] {
        let sublist = cups[...]
        let current = sublist[0]
        let lifted = sublist[1...3]
        let remainder = sublist[4...]

        var scratch = Array(remainder) + [current]
        scratch.sort()

        let currentIndex = scratch.firstIndex(of: current)!

        var target: Int
        if currentIndex == 0 {
            target = scratch.last!
        } else {
            target = scratch[currentIndex - 1]
        }

        let targetIndex = remainder.firstIndex(of: target)!
        var head = remainder.prefix(through: targetIndex)
        let tail = remainder.dropFirst(head.count)

        head.append(contentsOf: lifted)
        head.append(contentsOf: tail)
        head.append(current)

        return Array(head)
    }

    func resultFormat(_ cups: [Int]) -> String {
        let pivotIndex = cups.firstIndex(of: 1)!
        let head = cups[0 ..< pivotIndex]
        var tail = cups.dropFirst(head.count + 1)

        tail.append(contentsOf: head)

        return tail.map { n in
            String(n)
        }.joined()
    }
}


extension Day23: Problem {
    public func title() -> String {
        "--- Day 23: Crab Cups ---"
    }

    public func part1() -> String {
        var cups = input
        (0..<100).forEach { _ in
            cups = cycle(cups)
        }

        return resultFormat(cups)
    }

    public func part2() -> String {
        let cupList = CupList(input)

        var cup = cupList.cup(input[0])

        (0 ..< 10_000_000).forEach { n in
            cup = cupList.cycle(current: cup)
        }

        let cup1 = cupList.cup(1)
        let first = cup1.next!
        let second = first.next!

        return String((first.label * second.label))
    }

}
