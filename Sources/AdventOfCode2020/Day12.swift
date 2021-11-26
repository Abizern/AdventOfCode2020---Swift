import Foundation

public struct Day12 {
    private let input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(12)))
    }
}


extension Day12: Problem {
    public func title() -> String {
        "--- Day 12: Rain Risk ---"
    }

    public func part1() -> String {
        var x = 0
        var y = 0
        var d = 90

        input.forEach { operation in
            let op = operation.prefix(1)
            let value = Int(operation.dropFirst()) ?? 0

            switch op {
            case "N":
                y -= value
            case "E":
                x += value
            case "S":
                y += value
            case "W":
                x -= value
            case "F" where d == 90:
                x += value
            case "F" where d == 180:
                y += value
            case "F" where d == 270:
                x -= value
            case "F" where d == 0:
                y -= value
            case "R":
                d = (d + value) % 360
            case "L":
                d = (d + 360 - value) % 360
            default:
                fatalError("Unhandled input \(operation)")
            }
        }

        return String(abs(x) + abs(y))
    }

    public func part2() -> String {
        var x = 0
        var y = 0
        var waypointX = 10
        var waypointY = -1

        input.forEach { operation in
            let op = operation.prefix(1)
            let value = Int(operation.dropFirst()) ?? 0

            switch op {
            case "N":
                waypointY -= value
            case "E":
                waypointX += value
            case "S":
                waypointY += value
            case "W":
                waypointX -= value
            case "F":
                x += waypointX * value
                y += waypointY * value
            case "L" where value == 90,
                 "R" where value == 270:
                let (xx, yy) = (waypointX, waypointY)
                waypointX = yy
                waypointY = -xx
            case "L" where value == 180,
                 "R" where value == 180:
                let (xx, yy) = (waypointX, waypointY)
                waypointX = -xx
                waypointY = -yy
            case "L" where value == 270,
                 "R" where value == 90:
                let (xx, yy) = (waypointX, waypointY)
                waypointX = -yy
                waypointY = xx
            default:
                fatalError("Unhandled input \(operation)")
            }
        }

        return String(abs(x) + abs(y))
    }
}
