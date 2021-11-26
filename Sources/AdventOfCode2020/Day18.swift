import Foundation

public struct Day18 {
    let input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(18)))
    }
}


extension Day18: Problem {
    public func title() -> String {
        "--- Day 18: Operation Order ---"
    }

    public func part1() -> String {
        String(input
                .map(\.sanitisedInput)
                .map { toPostfix($0) }
                .map { evaluate($0) }
                .reduce(0, +))
    }

    public func part2() -> String {
        String(input
                .map(\.sanitisedInput)
                .map {  toPostfix($0, higherPrecedence: precedences) }
                .map { evaluate($0) }
                .reduce(0, +))
    }
}

let precedences = { (a: String, b: String) -> Bool in
    guard  case ("+", "*") = (a, b) else {
        return false
    }

    return true
}

func toPostfix(_ input: [String], higherPrecedence: (String, String) -> Bool = { _,_  in true } ) -> [String] {
    var output = [String]()
    var stack = Stack<String>()

    input.forEach { exp in
        switch exp {
        case "+", "*":
            while !stack.isEmpty, stack.peek != "(", higherPrecedence(stack.peek!, exp) {
                stack.pop().map { output.append($0) }
            }
            stack.push(exp)
        case "(":
            stack.push(exp)
        case ")":
            while !stack.isEmpty, stack.peek != "(" {
                stack.pop().map { output.append($0) }
            }
            stack.pop()
        default:
            output.append(exp)
        }
    }

    while !stack.isEmpty {
        stack.pop().map { output.append($0) }
    }

    return output
}

func evaluate(_ input: [String]) -> Int {
    var stack = Stack<Int>()

    input.forEach { exp in
        switch exp {
        case "+":
            stack.push(stack.pop()! + stack.pop()!)
        case "*":
            stack.push(stack.pop()! * stack.pop()!)
        default:
            Int(exp).map { stack.push($0) }
        }
    }

    return stack.pop()!
}

extension String {
    var sanitisedInput: [String] {
        replacingOccurrences(of: "(", with: "( ")
            .replacingOccurrences(of: ")", with: " )")
            .components(separatedBy: .whitespaces)
    }
}


