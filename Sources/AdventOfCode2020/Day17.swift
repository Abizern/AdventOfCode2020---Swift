import Foundation

public struct Day17 {
    let input: [String]

    public init(_ input: [String]) {
        self.input = input
    }

    public init() {
        self.init(Input.lines(from: .urlForInput(17)))
    }
}


extension Day17: Problem {
    public func title() -> String {
        "--- Day 17: Conway Cubes ---"
    }

    public func part1() -> String {
        var points = readPoints(input)
        return String(boot(&points))
    }

    public func part2() -> String {
        var points = readHyperPoints(input)
        return String(boot(&points))
    }
}

protocol Neighbouring: Hashable {
    var neighbours: Set<Self> { get }
    func neighbours(memo: inout [Self: Set<Self>]) -> Set<Self>
}

struct Point: Neighbouring {
    let x: Int
    let y: Int
    let z: Int

    var neighbours: Set<Point> {
        var set = Set<Point>()
        let range = (-1 ... 1)
        for i in range {
            for j in range {
                for k in range {
                    set.insert(Point(x: i+x, y: j+y, z: k+z))
                }
            }
        }
        set.remove(self)
        return set
    }

    func neighbours(memo: inout [Point: Set<Point>]) -> Set<Point> {
        guard let ns = memo[self] else {
            let calculatedNeighbours = neighbours
            memo[self] = calculatedNeighbours
            return calculatedNeighbours
        }
        return ns
    }
}

extension Point: Hashable {
    static func ==(lhs: Point, rhs: Point) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}


public struct HyperPoint: Neighbouring {
    let x: Int
    let y: Int
    let z: Int
    let w: Int

    var neighbours: Set<HyperPoint> {
        var set = Set<HyperPoint>()
        let range = (-1 ... 1)
        for i in range {
            for j in range {
                for k in range {
                    for l in range {
                        set.insert(HyperPoint(x: i+x, y: j+y, z: k+z, w: l+w))
                    }
                }
            }
        }
        set.remove(self)
        return set
    }

    func neighbours(memo: inout [HyperPoint: Set<HyperPoint>]) -> Set<HyperPoint> {
        guard let ns = memo[self] else {
            let calculatedNeighbours = neighbours
            memo[self] = calculatedNeighbours
            return calculatedNeighbours
        }

        return ns
    }
}

extension HyperPoint: Hashable {
    public static func ==(lhs: HyperPoint, rhs: HyperPoint) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z && lhs.w == rhs.w
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
        hasher.combine(w)
    }
}

extension Set where Element: Neighbouring & Hashable {
    func inactive(_ memo: inout [Element: Set<Element>]) -> Set<Element> {
        Set(flatMap { point in
            point.neighbours(memo: &memo)
        }).subtracting(self)
    }

    func neighboursFor(_ point: Element, memo: inout [Element: Set<Element>]) -> Int {
        intersection(point.neighbours(memo: &memo)).count
    }
}

let pt = Point(x: 0, y: 0, z: 0)

func cycle<T>(_ active: inout Set<T>, memo: inout [T: Set<T>]) where T: Neighbouring {
    let inactive = active.inactive
    active = active.filter { point in
        [2, 3].contains(active.neighboursFor(point, memo: &memo))
    }.union(inactive(&memo).filter { point in
        active.neighboursFor(point, memo: &memo) == 3
    })
}


func boot<T>(_ input: inout Set<T>) -> Int where T: Neighbouring {
    var memo = [T: Set<T>]()
    var input = input
    (0 ..< 6).forEach { _ in
        cycle(&input, memo: &memo)
    }

    return input.count
}

func readPoints(_ input: [String]) -> Set<Point> {
    let height = input.count
    var set = Set<Point>()

    (0..<height).forEach { j in
        for (i, c) in input[j].enumerated() {
            if c == "#" {
                let point = Point(x: i, y: j, z: 0)
                set.insert(point)
            }
        }
    }

    return set
}

func readHyperPoints(_ input: [String]) -> Set<HyperPoint> {
    let height = input.count
    var set = Set<HyperPoint>()

    (0..<height).forEach { j in
        for (i, c) in input[j].enumerated() {
            if c == "#" {
                let point = HyperPoint(x: i, y: j, z: 0, w: 0)
                set.insert(point)
            }
        }
    }

    return set
}
