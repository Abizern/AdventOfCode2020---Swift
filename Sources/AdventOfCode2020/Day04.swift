import Foundation

enum Field: Hashable, CaseIterable {
    case byr
    case iyr
    case eyr
    case hgt
    case hcl
    case ecl
    case pid
    case cid
}

extension Field {
    init?(_ string: Substring) {
        switch string {
        case "byr":
            self = .byr
        case "iyr":
            self = .iyr
        case "eyr":
            self = .eyr
        case "hgt":
            self = .hgt
        case "hcl":
            self = .hcl
        case "ecl":
            self = .ecl
        case "pid":
            self = .pid
        case "cid":
            self = .cid
        default:
            return nil
        }
    }

    static var validCases: Set<Field> {
        Set(allCases.filter { $0 != .cid })
    }

}

extension Dictionary where Key == Field, Value == String {
    static func createPassport(_ fields: [(Key, Value)]) -> [Key: Value] {
        var dict = [Key: Value]()
        fields.forEach { (key, value) in
            dict[key] = value
        }

        return dict
    }

    var isValidByr: Bool {
        guard let value = self[.byr],
              let year = Int(value)
        else { return false }

        return (1920...2002) ~= year
    }

    var isValidIyr: Bool {
        guard let value = self[.iyr],
              let year = Int(value)
        else { return false }

        return (2010...2020) ~= year
    }

    var isValidEyr: Bool {
        guard let value = self[.eyr],
              let year = Int(value)
        else { return false }

        return (2020...2030) ~= year
    }

    var isValidHgt: Bool {
        guard let value = self[.hgt] else { return false }
        var input = value[...]
        guard let height = Parser.uInt.run(&input) else { return false }

        if input == "in" {
            return (59...76) ~= height
        } else if input == "cm" {
            return (150...193) ~= height
        } else {
            return false
        }
    }

    var isValidHcl: Bool {
        guard
            let value = self[.hcl],
            value.hasPrefix("#"),
            value.count == 7,
            value.filter({ char in
                ("a"..."f") ~= char || ("0"..."9") ~= char
            }).count == 6
        else { return false }

        return true
    }

    var isValidEcl: Bool {
        guard let value = self[.ecl],
              ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
        else { return false }

        return true
    }

    var isValidPid: Bool {
        guard let value = self[.pid],
              value.count == 9,
              value.filter({ ("0"..."9") ~= $0 }).count == 9
        else { return false }

        return true
    }

    var isValid: Bool {
        let keySet = Set(keys)
        return keySet == Field.validCases || keySet == Set(Field.allCases)
    }

    var isStrictlyValid: Bool {
        isValidByr
            && isValidIyr
            && isValidEyr
            && isValidHgt
            && isValidHcl
            && isValidEcl
            && isValidPid
    }
}

typealias Passport = [Field: String]

public struct Day04 {
    let passports: [Passport]

    public init(_ input: [String]) {
        let parser = zip(Parser.prefix(count: 3),
                         Parser.prefix(":"))
        self.passports = input.map { line in
            line
                .components(separatedBy: .whitespacesAndNewlines)
                .compactMap { input -> (Field, String)? in
                    var string = input[...]
                    guard let (field, _) = parser.run(&string),
                          let key = Field(field)
                    else { return nil }

                    return (key, String(string))
                }
        }
        .map(Dictionary.createPassport)
    }

    public init() {
        self.init(Input.newLines(from: .urlForInput(4)))
    }
}


extension Day04: Problem {
    public func title() -> String {
        "--- Day 4: Passport Processing ---"
    }

    public func part1() -> String {
        String(passports
                .filter { $0.isValid }
                .count)
    }

    public func part2() -> String {
        String(passports
                .filter { $0.isStrictlyValid }
                .count)
    }
    
}
