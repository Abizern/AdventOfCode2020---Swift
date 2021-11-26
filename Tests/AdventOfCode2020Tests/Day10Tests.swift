import XCTest
import AdventOfCode2020

final class Day10Tests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day10(input1).part1(), "35")
        XCTAssertEqual(Day10(input2).part1(), "220")
        XCTAssertEqual(Day10(simple).part1(), "0")
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day10(input1).part2(), "8")
        XCTAssertEqual(Day10(input2).part2(), "19208")
        XCTAssertEqual(Day10(simple).part2(), "1")
    }
    
    func testPart1() {
        measure {
            XCTAssertEqual(Day10().part1(), "1914")
        }
        
    }
    
    func testPart2() {
        measure {
            XCTAssertEqual(Day10().part2(), "9256148959232")
        }
    }

    func testPart3() {
        measure {
            XCTAssertEqual(Day10().part2Dynamic(), 9256148959232)
        }
    }
}

private let simple = """
3
6
9
""".components(separatedBy: .newlines)

private let input1 = """
16
10
15
5
1
11
7
19
6
12
4
""".components(separatedBy: .newlines)

private let input2 = """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
""".components(separatedBy: .newlines)
