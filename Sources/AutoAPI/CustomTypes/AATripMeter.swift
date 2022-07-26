import Foundation
import HMUtilities

public final class AATripMeter: Codable, HMBytesConvertable {
    /// ID.
    public var id: UInt8
    /// Distance.
    public var distance: Measurement<UnitLength>

    /// Initialise `AATripMeter` with arguments.
    ///
    /// - parameters:
    ///     - id: ID.
    ///     - distance: Distance.
    public init(id: UInt8, distance: Measurement<UnitLength>) {
        self.bytes = [id.bytes, distance.bytes].flatMap { $0 }
        self.id = id
        self.distance = distance
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATripMeter` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 11 else {
            return nil
        }
    
        guard let id = UInt8(bytes: bytes[0..<1].bytes),
    		  let distance = Measurement<UnitLength>(bytes: bytes[1..<(1 + 10)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.id = id
        self.distance = distance
    }
}
