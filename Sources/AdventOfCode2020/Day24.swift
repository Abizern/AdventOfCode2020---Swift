import Foundation

public struct Day24 {
    let input: [String]

    func initialState() -> Set<Hexagon> {
        input
            .map(\.moves)
            .map(Hexagon.applying)
            .reduce(into: Set<Hexagon>()) { set, hexagon in
                guard !set.contains(hexagon) else {
                    set.remove(hexagon)
                    return
                }

                set.insert(hexagon)
            }
    }

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(24)))
    }
}


extension Day24: Problem {
    public func title() -> String {
        "--- Day 24: Lobby Layout ---"
    }

    public func part1() -> String {
        String(initialState().count)
    }

    public func part2() -> String {
        var memo = [Hexagon: Set<Hexagon>]()
        var input = initialState()

        (0 ..< 100).forEach { _ in
            cycle(&input, memo: &memo)
        }

        return String(input.count)
    }
}
