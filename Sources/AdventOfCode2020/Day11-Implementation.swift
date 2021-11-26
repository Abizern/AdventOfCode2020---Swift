import Foundation

struct Seat: Equatable {
    let x: Int
    let y: Int
    let _occupied: Bool

    init(x: Int, y: Int, occupied: Bool = false ) {
        self.x = x
        self.y = y
        self._occupied = occupied
    }
}

extension Seat {
    var isOccupied: Bool {
        _occupied
    }

    var occupied: Seat {
        Seat(x: x, y: y, occupied: true)
    }

    var unOccupied: Seat {
        Seat(x: x, y: y, occupied: false)
    }
}

func seatsFrom(_ layout: [[Character]]) -> [Seat] {
    var result = [Seat]()

    for j in (0 ..< layout.count) {
        for i in (0 ..< layout[0].count) {
            switch layout[j][i] {
            case "L":
                result.append(Seat(x: i, y: j))
            default:
                break
            }
        }
    }

    return result
}

private func neighbours(of seat: Seat, in grid: [[Character]]) -> [Seat] {
    let widthRange = (0 ..< grid[0].count)
    let heightRange = (0 ..< grid.count)
    var points = [Seat]()
    for di in (-1 ... 1) {
        for dj in (-1 ... 1) {
            guard !(di == 0 && dj == 0) else { continue }

            let ii = seat.x + di
            let jj = seat.y + dj

            guard widthRange.contains(ii),
                  heightRange.contains(jj),
                  grid[jj][ii] == "L"
            else {
                continue
            }

            points.append(Seat(x: ii, y: jj))
        }
    }

    return points
}

private func visible(from seat: Seat, in grid: [[Character]]) -> [Seat] {
    let widthRange = (0 ..< grid[0].count)
    let heightRange = (0 ..< grid.count)
    var points = [Seat]()
    for di in (-1 ... 1) {
        for dj in (-1 ... 1) {
            guard !(di == 0 && dj == 0) else { continue }

            var ii = seat.x + di
            var jj = seat.y + dj

            while widthRange.contains(ii) && heightRange.contains(jj) {
                if grid[jj][ii] == "L" {
                    points.append(Seat(x: ii, y: jj))
                    break
                }
                ii += di
                jj += dj
            }
        }
    }

    return points
}

func neighbours(of seats: [Seat], in grid: [[Character]]) -> [Int: [Int]] {
    var dict = [Int: [Int]]()

    seats.enumerated().forEach { item in
        dict[item.offset] = neighbours(of: item.element, in: grid)
            .compactMap { seats.firstIndex(of: $0) }
    }

    return dict
}

func visible(from seats: [Seat], in grid: [[Character]]) -> [Int: [Int]] {
    var dict = [Int: [Int]]()

    seats.enumerated().forEach { item in
        dict[item.offset] = visible(from: item.element, in: grid)
            .compactMap { seats.firstIndex(of: $0) }
    }

    return dict
}

func countOccupied(_ indices: [Int], in seats: [Seat]) -> Int {
    indices
        .map { seats[$0] }
        .filter(\.isOccupied)
        .count
}

func cycle(_ seats: [Seat], neighbours: [Int: [Int]]) -> [Seat] {
    var newSeats = [Seat]()
    for (i, seat) in seats.enumerated() {
        let nn = neighbours[i] ?? []
        let c = countOccupied(nn, in: seats)

        switch (seat.isOccupied, c) {
        case (false, 0):
            newSeats.append(seat.occupied)
        case (true, let c) where c >= 4:
            newSeats.append(seat.unOccupied)
        default:
            newSeats.append(seat)
        }
    }

    return newSeats
}

func cycle(_ seats: [Seat], visible: [Int: [Int]]) -> [Seat] {
    var newSeats = [Seat]()
    for (i, seat) in seats.enumerated() {
        let nn = visible[i] ?? []
        let c = countOccupied(nn, in: seats)

        switch (seat.isOccupied, c) {
        case (false, 0):
            newSeats.append(seat.occupied)
        case (true, let c) where c >= 5:
            newSeats.append(seat.unOccupied)
        default:
            newSeats.append(seat)
        }
    }

    return newSeats
}
