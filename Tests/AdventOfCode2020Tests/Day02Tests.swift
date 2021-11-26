import XCTest
import AdventOfCode2020

final class Day02Tests: XCTestCase {
    let testInput = [
        "1-3 a: abcde",
        "1-3 b: cdefg",
        "2-9 c: ccccccccc"
    ]

    func testPart1Example() {
        let result = Day02(testInput).part1()
        XCTAssertEqual(result, "2")
    }

    func testPart2Example() {
        let result = Day02(testInput).part2()
        XCTAssertEqual(result, "1")
    }

    func testPart1() {
        let problem = Day02(Input.lines(from: .urlForInput(2)))
        XCTAssertEqual(problem.part1(), "396")
    }

    func testPart2() {
        let problem = Day02(Input.lines(from: .urlForInput(2)))
        XCTAssertEqual(problem.part2(), "428")
    }
}
