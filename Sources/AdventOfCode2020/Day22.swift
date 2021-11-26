import Foundation

public struct Day22 {
    let input: ([Int], [Int])

    public init(_ input: [String]) {
        let decks = input.map { string in
            string
                .components(separatedBy: .newlines)
                .dropFirst()
                .compactMap(Int.init)
        }

        self.input = (decks[0], decks[1])
    }

    public init() {
        self.init(Input.newLines(from: .urlForInput(22)))
    }
}

extension Day22 {
    func play(p1: [Int], p2: [Int]) -> [Int] {
        var deck1 = p1
        var deck2 = p2

        while !deck1.isEmpty && !deck2.isEmpty {
            let c1 = deck1[0]
            var d1 = deck1.dropFirst()
            let c2 = deck2[0]
            var d2 = deck2.dropFirst()

                switch (c1, c2) {
                case let (a, b) where a > b:
                    d1 = d1 + [a, b]
                case let (a, b) where a < b:
                    d2 = d2 + [b, a]
                default:
                    fatalError()
                }

            deck1 = Array(d1)
            deck2 = Array(d2)
        }

        return [deck1, deck2].filter { !$0.isEmpty }[0]
    }

    func recursivePlay(p1: [Int], p2: [Int]) -> (Int, [Int]) {
        struct Memo: Equatable {
            let d1: [Int]
            let d2: [Int]

            init(_ d1: [Int], _ d2: [Int]) {
                self.d1 = d1
                self.d2 = d2
            }
        }

        var deck1 = p1
        var deck2 = p2
        var history = [Memo]()

        while !deck1.isEmpty && !deck2.isEmpty {
            let memo = Memo(deck1, deck2)
            if history.contains(memo) {
                deck2 = []
                break
            }

            history.append(memo)
            let c1 = deck1[0]
            var d1 = deck1.dropFirst()
            let c2 = deck2[0]
            var d2 = deck2.dropFirst()

            let winner: Int

            if d1.count >= c1 && d2.count >= c2 {
                let dd1 = Array(d1.prefix(c1))
                let dd2 = Array(d2.prefix(c2))
                winner = recursivePlay(p1: dd1, p2: dd2).0
            } else if c1 > c2 {
                winner = 1
            } else {
                winner = 2
            }


            switch (winner) {
            case 1:
                d1 = d1 + [c1, c2]
            default:
                d2 = d2 + [c2, c1]
            }

            deck1 = Array(d1)
            deck2 = Array(d2)
        }

        return deck1.count > deck2.count ? (1, deck1) : (2, deck2)
    }

    func score(_ deck: [Int]) -> Int {
        zip((1...), deck.reversed())
            .map { $0.0 * $0.1 }
            .reduce(0, +)
    }
}

extension Day22: Problem {
    public func title() -> String {
        "--- Day 22: Crab Combat ---"
    }

    public func part1() -> String {
        String(score(play(p1: input.0, p2: input.1)))
    }

    public func part2() -> String {
        String(score(recursivePlay(p1: input.0, p2: input.1).1))
    }
}
