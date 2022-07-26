import Foundation
import HMUtilities

public final class AADriverCardPresent: Codable, HMBytesConvertable {
    public typealias CardPresent = AADriverCardPresentCardPresent

    /// The driver number.
    public var driverNumber: UInt8
    /// CardPresent.
    public var cardPresent: CardPresent

    /// Initialise `AADriverCardPresent` with arguments.
    ///
    /// - parameters:
    ///     - driverNumber: The driver number.
    ///     - cardPresent: CardPresent.
    public init(driverNumber: UInt8, cardPresent: CardPresent) {
        self.bytes = [driverNumber.bytes, cardPresent.bytes].flatMap { $0 }
        self.driverNumber = driverNumber
        self.cardPresent = cardPresent
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADriverCardPresent` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let driverNumber = UInt8(bytes: bytes[0..<1].bytes),
    		  let cardPresent = CardPresent(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.driverNumber = driverNumber
        self.cardPresent = cardPresent
    }
}
