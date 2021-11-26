import Foundation
import XCTest
import AdventOfCode2020

final class Day13Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day13(testInput).part1(), "295")
    }

    func testPart1() {
        XCTAssertEqual(Day13().part1(), "4722")
    }

//    func testPart2() {
//        // This is the answer to my input, calculated in lisp which has better support for large number
//        XCTAssertEqual(Day13().part2(), "825305207525452")
//    }
}

private let testInput = """
939
7,13,x,x,59,x,31,19
""".components(separatedBy: .newlines)
