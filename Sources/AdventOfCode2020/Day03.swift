import Foundation

public struct Day03 {
    let input: [String]
    let width: Int
    let height: Int

    public init(_ input: [String]) {
        self.input = input
        self.width = input.first?.count ?? 0
        self.height = input.count
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(3)))
    }

    func collisionsForSlope(x: Int, y: Int) -> Int {
        var count = 0
        (1 ..< height / y).forEach { n in
            let row = input[y * n]
            let index = row.index(row.startIndex, offsetBy: (x * n) % width)
            if row[index] == "#" {
                count += 1
            }
        }

        return count
    }
}

extension Day03: Problem {
    public func title() -> String {
        "--- Day 3: Toboggan Trajectory ---"
    }

    public func part1() -> String {
        String(collisionsForSlope(x: 3, y: 1))
    }

    public func part2() -> String {
        String([(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
                .map(collisionsForSlope)
                .reduce(1, *))
    }
}
