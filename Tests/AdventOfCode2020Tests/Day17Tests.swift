import Foundation
import XCTest
import AdventOfCode2020

final class Day17Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day17(testInput)
        XCTAssertEqual(problem.part1(), "112")
    }

    func testPart2Example() {
        let problem = Day17(testInput)
        XCTAssertEqual(problem.part2(), "848")
    }

    func testPart1() {
        XCTAssertEqual(Day17().part1(), "271")
    }

    func testPart2() {
        XCTAssertEqual(Day17().part2(), "2064")
    }

}

private let testInput = """
.#.
..#
###
""".components(separatedBy: .newlines)

