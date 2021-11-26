import Foundation

enum Move {
    case east      // e
    case southeast // se
    case southwest // sw
    case west      // w
    case northwest // nw
    case northeast // ne
}

extension String {
    var moves: [Move] {
        var stack = self[...]
        var moves = [Move]()

        while !stack.isEmpty {
            switch stack.popFirst() {
            case "e":
                moves.append(.east)
            case "w":
                moves.append(.west)
            case "n":
                switch stack.popFirst() {
                case "w":
                    moves.append(.northwest)
                case "e":
                    moves.append(.northeast)
                default:
                    break
                }
            case "s":
                switch stack.popFirst() {
                case "e":
                    moves.append(.southeast)
                case "w":
                    moves.append(.southwest)
                default:
                    break
                }
            default:
                break
            }
        }

        return moves
    }
}


struct Hexagon: Hashable {
    var x: Int
    var y: Int
    var z: Int
}

extension Hexagon {
    mutating func move(_ move: Move) {
        switch move {
        case .east:
            x += 1
            y -= 1
        case .southeast:
            y -= 1
            z += 1
        case .southwest:
            x -= 1
            z += 1
        case .west:
            x -= 1
            y += 1
        case .northwest:
            y += 1
            z -= 1
        case .northeast:
            x += 1
            z -= 1
        }
    }

    static func applying(_ moves: [Move]) -> Hexagon {
        moves.reduce(into: Hexagon(x: 0, y: 0, z: 0)) { h, m in
            h.move(m)
        }
    }
}

extension Hexagon {
    var neighbours: Set<Hexagon> {
        var n = Set<Hexagon>()
        n.insert(Hexagon(x: x + 1, y: y - 1, z: z))
        n.insert(Hexagon(x: x - 1, y: y + 1, z: z))
        n.insert(Hexagon(x: x + 1, y: y, z: z - 1))
        n.insert(Hexagon(x: x - 1, y: y, z: z + 1))
        n.insert(Hexagon(x: x , y: y + 1, z: z - 1))
        n.insert(Hexagon(x: x , y: y - 1, z: z + 1))

        return n
    }

    func neighbours(memo: inout [Hexagon: Set<Hexagon>]) -> Set<Hexagon> {
        guard let n = memo[self] else {
            let calculatedN = neighbours
            memo[self] = calculatedN
            return calculatedN
        }

        return n
    }
}

extension Set where Element == Hexagon {
    func neighbouringWhite(_ memo: inout [Element: Set<Element>]) -> Set<Element> {
        Set(flatMap { point in
            point.neighbours(memo: &memo)
        }).subtracting(self)
    }

    func neighboursFor(_ point: Element, memo: inout [Element: Set<Element>]) -> Int {
        intersection(point.neighbours(memo: &memo)).count
    }
}

func cycle(_ black: inout Set<Hexagon>, memo: inout [Hexagon: Set<Hexagon>]) {
    let white = black.neighbouringWhite(&memo)
    let blackToWhite = black.filter { hexagon in
        let numBlackNeighbours = black.neighboursFor(hexagon, memo: &memo)
        return (numBlackNeighbours == 0 || numBlackNeighbours > 2)
    }

    let whiteToBlack = white.filter { hexagon in
        let numBlackNeighbours = black.neighboursFor(hexagon, memo: &memo)
        return numBlackNeighbours == 2
    }


    black = black.subtracting(blackToWhite).union(whiteToBlack)
}
