import Foundation

extension String {
    fileprivate var decomposeCase: (String, [(Int, String)]) {
        let containerPattern = #"^(.+?) bags contain"#
        let containedPattern = #"\b(\d+)\W([a-z]+\W[a-z]+)"#

        let container = capturedGroups(regex: containerPattern).first!
        let contained = capturedGroups(regex: containedPattern)

        guard !contained.isEmpty else { return (container, []) }

        var bags = [(Int, String)]()
        stride(from: 0, to: contained.count, by: 2).forEach { n in
            let number = Int(contained[n])!
            let bag = contained[n + 1]
            bags.append((number, bag))
        }

        return (container, bags)
    }
}
public struct Day07 {
    let input: [String]
    let baglist: [(String, [(Int, String)])]
    let bagDictionary: [String: [String]]
    let weightedBagDictionary: [String: [(Int, String)]]
    let target = "shiny gold"

    public init(_ input: [String]) {
        self.input = input
        self.baglist = input.map(\.decomposeCase)

        var dict = [String: [String]]()

        baglist.forEach { (containing, contained) in
            let key = containing
            let value = contained.map(\.1)

            dict[key] = value
        }

        self.bagDictionary = dict

        var weightedDict = [String: [(Int, String)]]()

        baglist.forEach { (containing, contained) in
            let key = containing
            let value = contained

            weightedDict[key] = value
        }

        self.weightedBagDictionary = weightedDict
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(7)))
    }

    func containers(for bag: String) -> [String] {
        var keys = [String]()

        bagDictionary.forEach { key, values in
            if values.contains(bag) {
                keys.append(key)
            }
        }

        if !keys.isEmpty {
            let newKeys = keys.flatMap(containers(for:))
            keys.append(contentsOf: newKeys)

        }

        return Array(Set(keys))
    }

    func countOfBags(for bag: String) -> Int {
        var total = 0
        let contained = weightedBagDictionary[bag] ?? []
        if contained.isEmpty {
            return 0
        }
        
        let containedBags = contained.map { $0.0 }.reduce(0, +)
        total = containedBags

        contained.forEach { count, bag in
            total += count * (countOfBags(for: bag))
        }
        return total
    }
}


extension Day07: Problem {
    public func title() -> String {
        "--- Day 7: Handy Haversacks ---"
    }

    public func part1() -> String {
        String(containers(for: target).count)
    }

    public func part2() -> String {
        String(countOfBags(for: target))
    }
}
