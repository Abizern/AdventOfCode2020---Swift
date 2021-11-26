import Foundation

public extension String {
    func capturedGroups(regex pattern: String) -> [String] {
        var result = [String]()
        let range = NSRange(startIndex..<endIndex, in: self)
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return result
        }

        regex.enumerateMatches(in: self, options: [], range: range) { (match, _, stop) in
            guard let match = match
            else { return }
            (1..<match.numberOfRanges).forEach { n in
                guard let subRange = Range(match.range(at: n), in: self) else { return }

                result.append(String(self[subRange]))
            }
        }

        return result
    }
}
