import Foundation

public protocol Problem {
    init()
    func title() -> String
    func part1() -> String
    func part2() -> String
}

extension Problem {
    public func title() -> String {
        "Not implemented yet"
    }

    public func part1() -> String {
        "Not solved yet..."
    }
    
    public func part2() -> String {
        "Not solved yet..."
    }
}
