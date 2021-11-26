import Foundation
import XCTest
import AdventOfCode2020

final class Day22Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day22(testInput)
        XCTAssertEqual(problem.part1(), "306")
    }

    func testPart2Example() {
        let problem = Day22(testInput)
        XCTAssertEqual(problem.part2(), "291")
    }

    func testPart1() {
        XCTAssertEqual(Day22().part1(), "33925")
    }

    func testPart2() {
        XCTAssertEqual(Day22().part2(), "33441")
    }

}

private let testInput = """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
""".components(separatedBy: "\n\n")

