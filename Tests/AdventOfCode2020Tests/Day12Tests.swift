import Foundation
import XCTest
import AdventOfCode2020

final class Day12Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day12(testInput).part1(), "25")
    }

    func testPart2Example() {
        XCTAssertEqual(Day12(testInput).part2(), "286")
    }

    func testPart1() {
        XCTAssertEqual(Day12().part1(), "759")
    }

    func testPart2() {
        XCTAssertEqual(Day12().part2(), "45763")
    }
}



private let testInput = """
F10
N3
F7
R90
F11
""".components(separatedBy: .newlines)


