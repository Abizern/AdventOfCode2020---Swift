import Foundation

public struct Day15 {
    let input: [Int]

    public init(_ input: [Int]) {
        self.input = input
    }
    
    public init() {
        self.init([9,19,1,6,0,5,4])
    }
}


extension Day15: Problem {
    public func title() -> String {
        "--- Day 15: Rambunctious Recitation ---"
    }

    public func part1() -> String {
        let seq = Array(Game(input).prefix(2020))
        guard let result = seq.last else {
            return "ERROR"
        }
        
        return String(result)
    }

    public func part2() -> String {
        let seq = Array(Game(input).prefix(30_000_000))
        guard let result = seq.last else {
            return "ERROR"
        }

        return String(result)
    }


}

struct Game: Sequence, IteratorProtocol {
    private let seed: [Int]
    private var memo = [Int: Int]()
    private let count: Int
    private var previous: Int
    private var cursor = 0

    init(_ seed: [Int]) {
        assert(seed.count > 0)
        self.seed = seed
        self.count = seed.count
        self.previous = seed[0]
    }

    mutating func next() -> Int? {
        defer { cursor += 1 }
        guard cursor >= count else {
            let number = seed[cursor]
            if cursor == 0 {
                previous = number
                return number
            }
            memo[previous] = cursor - 1
            previous = number
            return number
        }

        guard let lastSeen = memo[previous] else {
            let number = 0
            memo[previous] = cursor - 1
            previous = number
            return number
        }

        memo[previous] = cursor - 1
        let distance = cursor - lastSeen - 1
        previous = distance
        return distance
    }
}

