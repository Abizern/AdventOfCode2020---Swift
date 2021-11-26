 import Foundation

 func possibilitySolver<K, V>(_ dict: [K: Set<V>]) -> [K: V] {
    var possibilities = dict
    var result = [K: V]()

    while !possibilities.isEmpty {
        var scratch = [K: Set<V>]()
        possibilities.forEach { key, value in
            if value.count == 1 {
                result[key] = value.randomElement()
            }
        }

        let keys = result.keys
        let values = result.values
        for (key, valueSet) in possibilities {
            if keys.contains(key) {
                continue
            }
            scratch[key] = valueSet.filter { !values.contains($0) }
        }
        possibilities = scratch
    }

    return result
 }
