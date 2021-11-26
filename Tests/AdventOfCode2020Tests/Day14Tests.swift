import Foundation
import XCTest
import AdventOfCode2020

final class Day14Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day14(testInput1)
        XCTAssertEqual(problem.part1(), "165")
    }

    func testPart1() {
        XCTAssertEqual(Day14().part1(), "13476250121721")
    }

    func testPart2Example() {
        XCTAssertEqual(Day14(testInput2).part2(), "208")
    }

    func testPart2() {
        XCTAssertEqual(Day14().part2(), "4463708436768")
    }
}

private var testInput1 = """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
""".components(separatedBy: .newlines)

private var testInput2 = """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
""".components(separatedBy: .newlines)
