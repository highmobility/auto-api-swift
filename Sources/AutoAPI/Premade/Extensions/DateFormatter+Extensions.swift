import Foundation

extension DateFormatter {
    public static var hmFormatter: DateFormatter {
        DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    }

    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}
