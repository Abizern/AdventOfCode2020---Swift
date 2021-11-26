import Foundation

public struct Day11 {
    let input: [[Character]]

    public init(_ input: [String]) {
        self.input = input.map { str -> [Character] in
            var row = [Character]()
            str.forEach { row.append($0) }
            return row
        }
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(11)))
    }
}

extension Day11: Problem {
    public func title() -> String {
        "--- Day 11: Seating System ---"
    }

    public func part1() -> String {
        let seats = seatsFrom(input)
        let memo = neighbours(of: seats, in: input)

        var previous = seats
        var current = cycle(seats, neighbours: memo)

        while current != previous {
            let new = cycle(current, neighbours: memo)
            previous = current
            current = new
        }

        return String(current.filter(\.isOccupied).count)
    }

    public func part2() -> String {
        let seats = seatsFrom(input)
        let memo = visible(from: seats, in: input)

        var previous = seats
        var current = cycle(seats, visible: memo)

        while current != previous {
            let new = cycle(current, visible: memo)
            previous = current
            current = new
        }

        return String(current.filter(\.isOccupied).count)
    }
}
