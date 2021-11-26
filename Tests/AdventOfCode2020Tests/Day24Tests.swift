import Foundation
import XCTest
import AdventOfCode2020

final class Day24Tests: XCTestCase {
    func testPart1Example() {
        let problem = Day24(testInput)
        XCTAssertEqual(problem.part1(), "10")
    }

    func testPart1() {
        XCTAssertEqual(Day24().part1(), "287")
    }

    func testPart2Example() {
        let problem = Day24(testInput)
        XCTAssertEqual(problem.part2(), "2208")
    }

    func testPart2() {
        XCTAssertEqual(Day24().part2(), "3636")
    }
}

private let testInput = """
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
""".components(separatedBy: .newlines)
