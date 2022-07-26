import Foundation
import HMUtilities

public final class AACheckControlMessage: Codable, HMBytesConvertable {
    /// Check Control Message identifier.
    public var ID: UInt16
    /// Remaining time of the message.
    public var remainingTime: Measurement<UnitDuration>
    /// CCM text.
    public var text: String
    /// CCM status.
    public var status: String

    /// Initialise `AACheckControlMessage` with arguments.
    ///
    /// - parameters:
    ///     - ID: Check Control Message identifier.
    ///     - remainingTime: Remaining time of the message.
    ///     - text: CCM text.
    ///     - status: CCM status.
    public init(ID: UInt16, remainingTime: Measurement<UnitDuration>, text: String, status: String) {
        self.bytes = [ID.bytes, remainingTime.bytes, text.bytes.sizeBytes(amount: 2), text.bytes, status.bytes.sizeBytes(amount: 2), status.bytes].flatMap { $0 }
        self.ID = ID
        self.remainingTime = remainingTime
        self.text = text
        self.status = status
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AACheckControlMessage` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 12 else {
            return nil
        }
    
        guard let ID = UInt16(bytes: bytes[0..<2].bytes),
    		  let remainingTime = Measurement<UnitDuration>(bytes: bytes[2..<(2 + 10)].bytes),
    		  let text = bytes.extract(stringFrom: 12),
    		  let status = bytes.extract(stringFrom: (14 + text.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.ID = ID
        self.remainingTime = remainingTime
        self.text = text
        self.status = status
    }
}
