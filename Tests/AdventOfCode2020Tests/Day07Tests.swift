import XCTest
import AdventOfCode2020

private let testInput1 =
    """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
""".components(separatedBy: .newlines)

private let testInput2 =
    """
shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.
""".components(separatedBy: .newlines)

final class Day07Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day07(testInput1)
        XCTAssertEqual(problem.part1(), "4")
    }

    func testPart2Example() {
        XCTAssertEqual(Day07(testInput1).part2(), "32")
        XCTAssertEqual(Day07(testInput2).part2(), "126")
    }

    func testSetup() {
        let _ = Day07()
        XCTAssertTrue(true)
    }

    func testPart1() {
        XCTAssertEqual(Day07().part1(), "208")
    }

    func testPart2() {
        XCTAssertEqual(Day07().part2(), "1664")
    }
}
