import Foundation

let maskRegex = "mask = (\\S+)$"
let valueRegex = "mem.(\\d+). = (\\d+)$"

struct Instruction {
    let hash: String
    let address: Int
    let value: Int

    func pad(_ value: Int) -> String {
        let str = String(value, radix: 2)
        let padding = String(repeating: "0", count: 36 - str.count)
        return padding + str
    }

    var paddedValue: String {
        pad(value)
    }

    var paddedAddress: String {
        pad(address)
    }

    var baseHashedAddress: Int {
        var characters = [Character]()
        zip(hash, paddedAddress).forEach { h, v in
            switch (h, v) {
            case ("1", _):
                characters.append("1")
            case ("X", _):
                characters.append("1")
            case (_, let value):
                characters.append(value)
            }
        }
        
        return Int(String(characters), radix: 2) ?? 0
    }

    var hashToggles: [Int] {
        var toggles = [Int]()
        hash.reversed().enumerated().forEach { enumerator in
            guard enumerator.element == "X" else { return }
            toggles.append(1 << enumerator.offset)
        }

        return toggles
    }

    var hashedAddress: [Int] {
        var addresses = [baseHashedAddress]
        let toggles = hashToggles
        toggles.forEach { n in
            addresses.append(contentsOf: addresses.map { $0 - n })
        }

        return addresses
    }

    var part2Values:  (Int, [Int]) {
        (value, hashedAddress)
    }

    var hashedValue: Int {
        var characters = [Character]()
        zip(hash, paddedValue).forEach { h, v in
            switch (h, v) {
            case ("1", _):
                characters.append("1")
            case ("0", _):
                characters.append("0")
            case (_, let value):
                characters.append(value)
            }
        }
        return Int(String(characters), radix: 2) ?? 0
    }
}

public struct Day14 {
    let instructions: [Instruction]

    public init(_ input: [String]) {
        var instructions = [Instruction]()
        var hash = ""
        input.forEach { string in
            let values = string.capturedGroups(regex: valueRegex)
            if !values.isEmpty {
                instructions.append(Instruction(hash: hash, address: Int(values[0])!, value: Int(values[1])!))
                return
            }

            let hashGroup = string.capturedGroups(regex: maskRegex)
            if !hashGroup.isEmpty {
                hash = hashGroup[0]
                return
            }
        }
        self.instructions = instructions
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(14)))
    }
}


extension Day14: Problem {
    public func title() -> String {
        "--- Day 14: Docking Data ---"
    }
    
    public func part1() -> String {
        var d = [Int: Instruction]()
        instructions.forEach { d[$0.address] = $0 }
        return String(d.values
                        .map(\.hashedValue)
                        .reduce(0, +))
        
    }

    public func part2() -> String {
        var d = [Int: Int]()
        instructions.forEach { instruction in
            let (value, addresses) = instruction.part2Values
            addresses.forEach { n in
                d[n] = value
            }
        }

        return String(d.values.reduce(0, +))
    }
}
