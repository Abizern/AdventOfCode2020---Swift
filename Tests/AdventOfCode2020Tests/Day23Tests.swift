import Foundation
import XCTest
import AdventOfCode2020

final class Day23Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day23(testInput)
        XCTAssertEqual(problem.part1(), "67384529")
    }

    func testPart1() {
        XCTAssertEqual(Day23().part1(), "76385429")
    }

    func testPart2Example() {
        let problem = Day23(testInput)
        XCTAssertEqual(problem.part2(), "149245887792")
    }

    func testPart2() {
        XCTAssertEqual(Day23().part2(), "12621748849")
    }
}

private let testInput = "389125467"
