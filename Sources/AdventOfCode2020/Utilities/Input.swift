import Foundation

/// Functions to simplify reading inputs
///
/// Error handling is unsophisticated as inputs are fixed and really should work.
public enum Input {
    /// The contents of the `URL` as a single, trimmed, String
    public static func string(from url: URL) -> String {
        do {
            return try String(contentsOf: url)
                .trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return ""
        }
    }

    /// The contents of the `URL` as an array of Strings
    public static func lines(from url: URL) -> [String] {
        string(from: url).components(separatedBy: .newlines)
    }

    /// The contents of the `URL` as an array of strings split by blank lines
    public static func newLines(from url: URL) -> [String] {
        string(from: url).components(separatedBy: "\n\n")
    }
    /// The contents of the `URL` as a single Int
    public static func int(from url: URL) -> Int {
        Int(string(from: url)) ?? 0
    }

    /// The contents of the `URL` as an array of Ints
    /// - Parameter url: The url to load the input from
    /// - Returns: An array of Ints
    public static func ints(from url: URL) -> [Int] {
        lines(from: url).compactMap(Int.init)
    }

    /// The contents of the `URL` as a Set of Ints
    public static func set(from url: URL) -> Set<Int> {
        Set(ints(from: url))
    }
}
