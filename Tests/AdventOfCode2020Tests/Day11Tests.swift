import Foundation
import XCTest
import AdventOfCode2020

final class Day11Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day11(testInput).part1(), "37")
    }

    func testPart2Example() {
        XCTAssertEqual(Day11(testInput).part2(), "26")
    }

    func testPart1() {
        XCTAssertEqual(Day11().part1(), "2344")
    }

    func testPart2() {
        XCTAssertEqual(Day11().part2(), "")
    }
}

private var testInput = """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
""".components(separatedBy: .newlines)
