import Foundation

public struct Day08 {
    let input: [Machine.Instruction]

    public init(_ input: [String]) {
        self.input = input.map(\.instruction)
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(8)))
    }
}

extension Day08: Problem {
    public func title() -> String {
        "--- Day 8: Handheld Halting ---"
    }

    public func part1() -> String {
        guard case .repeating(let result) = Machine.run(input) else {
            return "Solution didn't work"
        }
        return String(result)
    }

    public func part2() -> String {
        func filterJmpNop(_ input: (Int, Machine.Instruction)) -> Int? {
            guard case .acc(_) = input.1 else {
                return input.0
            }
            return nil
        }

        func runMachineToggling(_ index: Int) -> Machine.Termination {
            var newInput = input
            newInput[index] = newInput[index].toggle()
            return Machine.run(newInput)
        }

        func filterTerminated(_ condition: Machine.Termination) -> Bool {
            if case .success(_) = condition {
                return true
            }

            return false
        }

        let results = input
            .enumerated()
            .compactMap(filterJmpNop)
            .map (runMachineToggling)
            .filter(filterTerminated)

        switch results[0] {
        case .success(let x):
            return String(x)
        default:
            return "Solution didn't work"
        }
    }
}

enum Machine {
    enum Instruction {
        case acc(Int)
        case jmp(Int)
        case nop(Int)
    }

    enum Termination {
        case repeating(Int)
        case success(Int)
        case failure
    }

    static func run(_ instructions: [Instruction]) -> Termination {
        var cursor = 0
        var accumulator = 0
        var memo = Set<Int>()
        let length = instructions.count

        repeat {
            memo.insert(cursor)
            let instruction = instructions[cursor]
            instruction.run(accumulator: &accumulator, cursor: &cursor)
        } while !memo.contains(cursor) && cursor < length

        if cursor == length { return .success(accumulator)}
        else if cursor < length { return .repeating(accumulator)}
        else { return .failure }
    }
}

extension Machine.Instruction {
    func toggle() -> Machine.Instruction {
        switch self {
        case .acc(_): return self
        case .jmp(let x): return .nop(x)
        case .nop(let x): return .jmp(x)
        }
    }

    func run(accumulator accum: inout Int, cursor: inout Int) {
        switch self {
        case .acc(let x):
            accum += x
            cursor += 1
        case .jmp(let x):
            cursor += x
        case .nop(_):
            cursor += 1
        }
    }
}

private extension String {
    var instruction: Machine.Instruction {
        let input = self[...]
        let offset = Int(input.dropFirst(4))!

        switch input.first {
        case "a":
            return .acc(offset)
        case "j":
            return .jmp(offset)
        default:
            return .nop(offset)
        }
    }
}
