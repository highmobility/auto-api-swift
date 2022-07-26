import Foundation
import HMUtilities

public final class AAZone: Codable, HMBytesConvertable {
    /// Horizontal component of the matrix.
    public var horizontal: UInt8
    /// Vertical component of the matrix.
    public var vertical: UInt8

    /// Initialise `AAZone` with arguments.
    ///
    /// - parameters:
    ///     - horizontal: Horizontal component of the matrix.
    ///     - vertical: Vertical component of the matrix.
    public init(horizontal: UInt8, vertical: UInt8) {
        self.bytes = [horizontal.bytes, vertical.bytes].flatMap { $0 }
        self.horizontal = horizontal
        self.vertical = vertical
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAZone` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let horizontal = UInt8(bytes: bytes[0..<1].bytes),
    		  let vertical = UInt8(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.horizontal = horizontal
        self.vertical = vertical
    }
}
