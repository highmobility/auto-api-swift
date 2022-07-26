import Foundation
import HMUtilities

public final class AASupportedCapability: Codable, HMBytesConvertable {
    /// The identifier of the supported capability.
    public var capabilityID: UInt16
    /// Array of supported property identifiers.
    public var supportedPropertyIDs: [UInt8]

    /// Initialise `AASupportedCapability` with arguments.
    ///
    /// - parameters:
    ///     - capabilityID: The identifier of the supported capability.
    ///     - supportedPropertyIDs: Array of supported property identifiers.
    public init(capabilityID: UInt16, supportedPropertyIDs: [UInt8]) {
        self.bytes = [capabilityID.bytes, supportedPropertyIDs.bytes.sizeBytes(amount: 2), supportedPropertyIDs.bytes].flatMap { $0 }
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AASupportedCapability` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }
    
        guard let capabilityID = UInt16(bytes: bytes[0..<2].bytes),
    		  let supportedPropertyIDs = bytes.extract(bytesFrom: 2) else {
            return nil
        }
    
        self.bytes = bytes
        self.capabilityID = capabilityID
        self.supportedPropertyIDs = supportedPropertyIDs
    }
}
