import Foundation
import AdventOfCode2020

struct Solution {
    enum Part {
        case one
        case two
        case all

        init(_ n: Int) {
            if n == 1 {
                self = .one
            } else if n == 2 {
                self = .two
            } else {
                self = .all
            }
        }
    }

    let problem: Problem
    var part: Part

    init(_ problem: Problem, part: Int? = nil) {
        self.problem = problem
        self.part = part != nil ? Part(part!) : .all
    }

    func outputPart1() -> String {
        """
        \(problem.title())
        Part 1: \(problem.part1())

        """
    }

    func outputPart2() -> String {
        """
        \(problem.title())
        Part 2: \(problem.part2())

        """
    }

    func outputAll() -> String {
        """
        \(problem.title())
        Part 1: \(problem.part1())
        Part 2: \(problem.part2())

        """
    }

    func output() -> String {
        switch part {
        case .one:
            return outputPart1()
        case .two:
            return outputPart2()
        case .all:
            return outputAll()
        }
    }
}

extension Solution {
    private static var allProblems: [Problem.Type] = [
        Day01.self,
        Day02.self,
        Day03.self,
        Day04.self,
        Day05.self,
        Day06.self,
        Day07.self,
        Day08.self,
        Day09.self,
        Day10.self,
        Day11.self,
        Day12.self,
        Day13.self,
        Day14.self,
        Day15.self,
        Day16.self,
        Day17.self,
        Day18.self,
        Day19.self,
        Day20.self,
        Day21.self,
        Day22.self,
        Day23.self,
        Day24.self,
        Day25.self
    ]

    static func forDay(_ day: Int, part: Int) -> [Solution] {
        let day = day > 0 && day < Solution.count ? day : 0 // guilding the lily, but better safe than sorry

        let problem = allProblems[day - 1].init()
        return [Solution(problem, part: part)]
    }

    static func all() -> [Solution] {
        allProblems.map { problem in
            Solution(problem.init())
        }
    }

    static var count: Int {
        allProblems.count
    }
}

