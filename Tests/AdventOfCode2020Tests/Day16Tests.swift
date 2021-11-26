import Foundation
import XCTest
@testable import AdventOfCode2020

final class Day16Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day16(testInput)
        XCTAssertEqual(problem.part1(), "71")
    }

    func testPart1() {
        XCTAssertEqual(Day16().part1(), "25788")
    }

    func testPart2() {
        XCTAssertEqual(Day16().part2(), "3902565915559")
    }

}

private let testInput = """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
""".components(separatedBy: "\n\n")

private let testInput2 = """
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
1,20,3
3,9,18
15,1,5
5,14,9
""".components(separatedBy: "\n\n")
