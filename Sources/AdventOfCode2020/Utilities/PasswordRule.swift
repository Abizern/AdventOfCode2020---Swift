import Foundation

struct PasswordRule {
    let min: UInt
    let max: UInt
    let char: Character

    func isValid(_ input: String) -> Bool {
        let numChars = input.filter { $0 == char }.count

        return numChars >= min && numChars <= max
    }

    func isStrictlyValid(_ input: String) -> Bool {
        let firstIndex = input.index(input.startIndex, offsetBy: Int(min) - 1)
        let secondIndex = input.index(input.startIndex, offsetBy: Int(max) - 1)
        let atFirst = input[firstIndex] == char
        let atSecond = input[secondIndex] == char

        switch (atFirst, atSecond) {
        case (true, false):
            return true
        case (false, true):
            return true
        default:
            return false
        }
    }
}

extension PasswordRule {
    init(_ input: (UInt, Void, UInt, Void, Character, Void)) {
        let (min, _, max, _, char, _) = input

        self.min = min
        self.max = max
        self.char = char
    }
}

struct AdvancedPasswordRule {
    let firstIndex: Int
    let secondIndex: Int
    let character: Character
}
