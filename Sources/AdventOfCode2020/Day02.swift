import Foundation

extension PasswordRule {
    init(_ inputs: [String]) {
        let min = UInt(inputs[0])!
        let max = UInt(inputs[1])!
        let char = Character(inputs[2])

        self.min = min
        self.max = max
        self.char = char
    }
}

private extension String {
    var decomposeCase: (PasswordRule, String) {
        let pattern = #"^(\d+)-(\d+)\W([a-z]):\W([a-z]+)$"#
        let extracted = self.capturedGroups(regex: pattern)

        return (PasswordRule(extracted), extracted.last!)
    }
}

public struct Day02 {
    let input: [String]
    let cases: [(PasswordRule, String)]

    public init(_ input: [String]) {
        self.input = input
        self.cases = input.map(\.decomposeCase)
    }
    
    public init() {
        self.init(Input.lines(from: .urlForInput(2)))
    }
}

extension Day02 {
    static var ruleParser: Parser<PasswordRule> {
        let uIntParser = Parser.uInt
        return zip(
            uIntParser,
            Parser.prefix("-"),
            uIntParser,
            Parser.prefix(" "),
            Parser.char,
            Parser.prefix(": ")
        ).map(PasswordRule.init)
    }

    static func inputParser(_ input: String) -> (PasswordRule, String)? {
        var input = input[...]
        guard let rule = Day02.ruleParser.run(&input) else { return nil }
        return (rule, String(input))
    }
}


extension Day02: Problem {
    public func title() -> String {
        "--- Day 2: Password Philosophy ---"
    }

    public func part1() -> String {
        String(cases
                .map { (rule, input) in
                    rule.isValid(input)
                }
                .filter { $0 }
                .count)
    }

    public func part2() -> String {
        String(cases
                .map { (rule, input) in
                    rule.isStrictlyValid(input)
                }
                .filter { $0 }
                .count)
    }
}
//    "1-3 a: abcde",
//    "1-3 b: cdefg",
//    "2-9 c: ccccccccc"
