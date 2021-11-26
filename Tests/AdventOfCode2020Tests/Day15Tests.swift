import Foundation
import XCTest
import AdventOfCode2020

final class Day15Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day15(tInput1).part1(), "436")
        XCTAssertEqual(Day15(tInput2).part1(), "1")
        XCTAssertEqual(Day15(tInput3).part1(), "10")
        XCTAssertEqual(Day15(tInput4).part1(), "27")
        XCTAssertEqual(Day15(tInput5).part1(), "78")
        XCTAssertEqual(Day15(tInput6).part1(), "438")
        XCTAssertEqual(Day15(tInput7).part1(), "1836")
    }

    func testPart1() {
        XCTAssertEqual(Day15().part1(), "1522")
    }

    func testPart2Example() {
        XCTAssertEqual(Day15(tInput1).part2(), "175594")
    }

    func testPart2() {
        XCTAssertEqual(Day15().part2(), "18234")
    }
}

let tInput1 = [0, 3, 6]
let tInput2 = [1,3,2]
let tInput3 = [2,1,3]
let tInput4 = [1,2,3]
let tInput5 = [2,3,1]
let tInput6 = [3,2,1]
let tInput7 = [3,1,2]
