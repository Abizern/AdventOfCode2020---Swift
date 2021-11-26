import XCTest
import AdventOfCode2020

private let testInput = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
""".components(separatedBy: .newlines)

final class Day08Tests: XCTestCase {
    let problem = Day08(testInput)

    func testPart1Example() {
        XCTAssertEqual(problem.part1(), "5")
    }

    func testPart2Example() {
        XCTAssertEqual(problem.part2(), "8")
    }

    func testSetup() {
        let _ = Day08()
        XCTAssertTrue(true)
    }

    func testPart1() {
        XCTAssertEqual(Day08().part1(), "2034")
    }

    func testPart2() {
        XCTAssertEqual(Day08().part2(), "672")
    }
}
