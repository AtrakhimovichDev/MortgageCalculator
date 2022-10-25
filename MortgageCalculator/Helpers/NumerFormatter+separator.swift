import Foundation

extension Formatter {
    static func withSeparator(_ separator: String) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = separator
        return formatter
    }
}

extension Numeric {
    func formattedWithSeparator(_ separator: String) -> String {
        Formatter.withSeparator(separator).string(for: self) ?? ""
    }
}
