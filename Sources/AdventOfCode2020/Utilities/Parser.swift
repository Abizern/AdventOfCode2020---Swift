import Foundation

public struct Parser<Output> {
    public let run: (inout Substring) -> Output?
}

public extension Parser {
    /// A parser that always returns the specified value
    static func always(_ output: Output) -> Self {
        Self { _ in output }
    }

    /// A parser that always fails
    static var never: Self {
        Self { _ in nil }
    }

    func map<NewOutput>(_ f: @escaping (Output) -> NewOutput) -> Parser<NewOutput> {
        .init { input in
            self.run(&input).map(f)
        }
    }

    func flatMap<B>(_ f: @escaping (Output) -> Parser<B>) -> Parser<B> {
        Parser<B> { input in
            let original = input
            let matchA = self.run(&input)
            let parserB = matchA.map(f)
            guard let matchB = parserB?.run(&input) else {
                input = original
                return nil
            }

            return matchB
        }
    }
}


extension Parser {
    /// Extension to make testing and debugging easier
    func run(_ input: String) -> (match: Output?, rest: Substring) {
        var input = input[...]
        let match = self.run(&input)
        return (match, input)
    }
}

public extension Parser where Output == UInt {
    /// Parse a `UInt`
    static let uInt = Self { input in
        let candidate = input.prefix(while: { $0.isNumber })
        guard let match = UInt(candidate)
        else { return nil }
        input.removeFirst(candidate.count)

        return match
    }
}

public extension Parser where Output == Character {
    /// Parse the first character off the string
    static let char = Self { input in
        guard !input.isEmpty else { return nil }

        return input.removeFirst()
    }
}

public extension Parser where Output == Substring {
    static func prefix(count: Int) -> Self {
        Self { input in
            guard input.count >= count else { return nil }
            let result = input.prefix(count)
            input.removeFirst(count)

            return result
        }
    }
}

public extension Parser where Output == Void {
    /// Parse and discard the prefix
    static func prefix(_ p: String) -> Self {
        Self { input in
            guard input.hasPrefix(p) else { return nil }
            input.removeFirst(p.count)

            return ()
        }
    }

}

public func zip<Output1, Output2>(
    _ p1: Parser<Output1>,
    _ p2: Parser<Output2>
) -> Parser<(Output1, Output2)> {
    .init { input -> (Output1, Output2)? in
        let original = input
        guard let output1 = p1.run(&input) else { return nil }
        guard let output2 = p2.run(&input) else {
            input = original
            return nil
        }

        return (output1, output2)
    }
}

public func zip<Output1, Output2, Output3>(
    _ p1: Parser<Output1>,
    _ p2: Parser<Output2>,
    _ p3: Parser<Output3>
) -> Parser<(Output1, Output2, Output3)> {
    zip(p1, zip(p2, p3))
        .map { output1, output23 in
            (output1, output23.0, output23.1)
        }
}

public func zip<Output1, Output2, Output3, Output4>(
    _ p1: Parser<Output1>,
    _ p2: Parser<Output2>,
    _ p3: Parser<Output3>,
    _ p4: Parser<Output4>
) -> Parser<(Output1, Output2, Output3, Output4)> {
    zip(p1, zip(p2, p3, p4))
        .map { output1, output234 in
            (output1, output234.0, output234.1, output234.2)
        }
}

public func zip<Output1, Output2, Output3, Output4, Output5>(
    _ p1: Parser<Output1>,
    _ p2: Parser<Output2>,
    _ p3: Parser<Output3>,
    _ p4: Parser<Output4>,
    _ p5: Parser<Output5>
) -> Parser<(Output1, Output2, Output3, Output4, Output5)> {
    zip(p1, zip(p2, p3, p4, p5))
        .map { output1, output2345 in
            (output1, output2345.0, output2345.1, output2345.2, output2345.3)
        }
}

public func zip<Output1, Output2, Output3, Output4, Output5, Output6>(
    _ p1: Parser<Output1>,
    _ p2: Parser<Output2>,
    _ p3: Parser<Output3>,
    _ p4: Parser<Output4>,
    _ p5: Parser<Output5>,
    _ p6: Parser<Output6>
) -> Parser<(Output1, Output2, Output3, Output4, Output5, Output6)> {
    zip(p1, zip(p2, p3, p4, p5, p6))
        .map { output1, output23456 in
            (output1, output23456.0, output23456.1, output23456.2, output23456.3, output23456.4)
        }
}
