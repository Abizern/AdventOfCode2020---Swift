import Foundation
import XCTest
import AdventOfCode2020

private let input = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
""".components(separatedBy: .newlines)


final class Day03Tests: XCTestCase {
    func testPartExample() {
        let day3 = Day03(input)
        XCTAssertEqual(day3.part1(), "7")
    }
    
    func testPart2Example() {
        let day3 = Day03(input)
        XCTAssertEqual(day3.part2(), "336")
    }
    
    func testPart1() {
        XCTAssertEqual(Day03().part1(), "280")
    }
    
    func testPart2() {
        XCTAssertEqual(Day03().part2(), "4355551200")
    }
}
