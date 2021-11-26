import Foundation
import XCTest
import AdventOfCode2020

final class Day01Tests: XCTestCase {
    let testInput = Set([
        1721,
        979,
        366,
        299,
        675,
        1456
    ])
    
    func testPart1Example() {
        let problem = Day01(testInput)
        XCTAssertEqual(problem.part1(), "514579")
    }
    
    func testPart2Example() {
        let problem = Day01(testInput)
        XCTAssertEqual(problem.part2(), "241861950")
    }
    
    func testPart1() {
        let problem = Day01(Input.set(from: .urlForInput(1)))
        XCTAssertEqual(problem.part1(), "876459")
    }
    
    func testPart2() {
        let problem = Day01(Input.set(from: .urlForInput(1)))
        XCTAssertEqual(problem.part2(), "116168640")
    }
}
