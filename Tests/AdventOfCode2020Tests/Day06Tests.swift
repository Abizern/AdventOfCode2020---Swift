import XCTest
import AdventOfCode2020

private let testInput =
"""
abc

a
b
c

ab
ac

a
a
a
a

b
""".components(separatedBy: "\n\n")

final class Day06Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day06(testInput)
        XCTAssertEqual(problem.part1(), "11")
    }

    func testPart2Example() {
        let problem = Day06(testInput)
        XCTAssertEqual(problem.part2(), "6")
    }

    func testPart1() {
        XCTAssertEqual(Day06().part1(), "6504")
    }

    func testPart2() {
        XCTAssertEqual(Day06().part2(), "3351")
    }
}
