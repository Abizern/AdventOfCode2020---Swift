import Foundation

public struct Day21 {
    let input: [[[String]]]

    public init(_ input: [String]) {
        self.input = input.map(\.parsed)
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(21)))
    }
}

extension Day21 {
    func possibleAllergens() -> [String: Set<String>] {
        var allergenDict = [String: Set<String>]()

        input.forEach { list in
            let ingredients = list[0]
            let allergens = list[1]
             allergens.forEach { allergen in
                if let set = allergenDict[allergen] {
                    allergenDict[allergen] = set.intersection(Set(ingredients))
                } else {
                    allergenDict[allergen] = Set(ingredients)
                }
            }
        }

        return allergenDict
    }

    func allIngredients() -> [String] {
        input.flatMap { $0[0] }
    }
}


extension Day21: Problem {
    public func title() -> String {
        "--- Day 21: Allergen Assessment ---"
    }

    public func part1() -> String {
        let allergens = possibleAllergens().values.reduce(Set<String>()) { accum, set in
            return accum.union(set)
        }
        let ingredients = allIngredients()
        let ingredientsSet = Set(ingredients)
        let allergenFree = Array(ingredientsSet.subtracting(allergens))
        
        return String(ingredients.filter { allergenFree.contains($0) }.count)
    }

    public func part2() -> String {
        possibilitySolver(possibleAllergens())
            .reduce(into: [(String, String)]()) { (accum, item) in
                accum.append((item.key, item.value))
            }
            .sorted { $0 < $1 }
            .map(\.1)
            .joined(separator: ",")
    }
}

private extension String {
    var parsed: [[String]] {
        replacingOccurrences(of: " (contains ", with: ":")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: ",", with: " ")
            .split(separator: ":")
            .map { substring in
                substring.components(separatedBy: .whitespaces)
                    .filter { !$0.isEmpty }
            }
    }
}
