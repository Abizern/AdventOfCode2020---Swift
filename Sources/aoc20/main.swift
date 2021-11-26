//
//  File.swift
//  
//
//  Created by Abizer Nasir on 01/12/2020.
//

import Foundation
import ArgumentParser
import AdventOfCode2020

struct Select: ParsableCommand {
    @Option(name: .shortAndLong, help: "The day to run")
    var day: Int = 0

    @Option(name: .shortAndLong, help: "Which part to run: 1 or 2, leave blank for all")
    var part: Int = 0

    @Flag(name: .shortAndLong, help: "Runs all days and parts. Ignores other options")
    var all = false

    func validate() throws {
        if all {
            // Ignores all other parameters
            return
        }

        if day == 0 && part == 0 && !all {
            // These are the defaults, so no need to validate
            return
        }

        guard day > 0 && day <= Solution.count else {
            throw ValidationError("Please enter a day number between 1 and \(Solution.count)")
        }

    }

    mutating func run() throws {
        solutionsToRun(day: day, part: part, all: all)
            .forEach { print($0.output()) }
    }

    func solutionsToRun(day: Int, part: Int, all: Bool) -> [Solution] {
        if all {
            return Solution.all()
        }

        if day == 0 && part == 0 && !all {
            return Solution.all()
        }

        return Solution.forDay(day, part: part)
    }
}

Select.main()

