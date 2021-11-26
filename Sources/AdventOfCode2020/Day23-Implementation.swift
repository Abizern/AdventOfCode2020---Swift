import Foundation

final class CupList {
    var dict = Dictionary<Int, Cup>(minimumCapacity: 1_000_000)

    final class Cup {
        let label: Int
        var next: Cup?

        required init(_ value: Int, next: CupList.Cup? = nil) {
            self.label = value
            self.next = next
        }
    }

    init(_ list: [Int]) {
        var previous = Cup(1_000_000)
        dict[previous.label] = previous


        for n in stride(from: 999_999, through: 10, by: -1) {
            let label = Cup(n, next: previous)
            dict[n] = label
            previous = label
        }

        for n in list.reversed() {
            let label = Cup(n, next: previous)
            dict[n] = label
            previous = label
        }

        dict[1_000_000]?.next = previous
    }
}

extension CupList {
    func cup(_ label: Int) -> Cup {
        dict[label]!
    }

    func snip(after current: Cup) -> [Int] {
        guard let first = current.next,
              let second = first.next,
              let third = second.next,
              let after = third.next
        else {
            fatalError()
        }

        current.next = after

        let labels = [first, second, third].map(\.label)
        labels.forEach { n in
            dict[n] = nil
        }

        return labels
    }

    func insert(_ labels: [Int], after target: Cup) {
        var previous = target.next
        labels.reversed().forEach { n in
            let cup = Cup(n, next: previous)
            dict[n] = cup
            previous = cup
        }

        target.next = previous
    }

    func target(_ current: Cup) -> Cup {
        var targetLabel = current.label
        var targetCup: Cup? = nil

        while targetCup == nil {
            if targetLabel == 1 {
                targetLabel = 1_000_000
            } else {
                targetLabel -= 1
            }

            targetCup = dict[targetLabel]
        }

        return targetCup!
    }

    func cycle(current: Cup) -> Cup {
        let snipped = snip(after: current)
        insert(snipped, after: target(current))

        return current.next!
    }
}

extension CupList.Cup: Hashable {
    static func == (lhs: CupList.Cup, rhs: CupList.Cup) -> Bool {
        lhs.label == rhs.label
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
    }
}


