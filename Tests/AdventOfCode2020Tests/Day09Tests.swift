import XCTest
import AdventOfCode2020

private let testInput = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
""".components(separatedBy: .newlines).compactMap(Int.init)

final class Day09Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day09(testInput)
        let result = problem.solve1(length: 5)
        XCTAssertEqual(result, 127)
    }

    func testPart2Example() {
        let problem = Day09(testInput)
        let result = problem.solve2(length: 5)
        XCTAssertEqual(result, 62)
    }

    func testPart1() {
        XCTAssertEqual(Day09().part1(), "466456641")
    }

    func testPart2() {
        XCTAssertEqual(Day09().part2(), "55732936")
    }
}
