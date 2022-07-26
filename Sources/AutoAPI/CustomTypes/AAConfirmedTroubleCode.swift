import Foundation
import HMUtilities

public final class AAConfirmedTroubleCode: Codable, HMBytesConvertable {
    /// Identifier.
    public var ID: String
    /// Electronic Control Unit address.
    public var ecuAddress: String
    /// Electronic Control Unit variant name.
    public var ecuVariantName: String
    /// Status.
    public var status: String

    /// Initialise `AAConfirmedTroubleCode` with arguments.
    ///
    /// - parameters:
    ///     - ID: Identifier.
    ///     - ecuAddress: Electronic Control Unit address.
    ///     - ecuVariantName: Electronic Control Unit variant name.
    ///     - status: Status.
    public init(ID: String, ecuAddress: String, ecuVariantName: String, status: String) {
        self.bytes = [ID.bytes.sizeBytes(amount: 2), ID.bytes, ecuAddress.bytes.sizeBytes(amount: 2), ecuAddress.bytes, ecuVariantName.bytes.sizeBytes(amount: 2), ecuVariantName.bytes, status.bytes.sizeBytes(amount: 2), status.bytes].flatMap { $0 }
        self.ID = ID
        self.ecuAddress = ecuAddress
        self.ecuVariantName = ecuVariantName
        self.status = status
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAConfirmedTroubleCode` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 0 else {
            return nil
        }
    
        guard let ID = bytes.extract(stringFrom: 0),
    		  let ecuAddress = bytes.extract(stringFrom: (2 + ID.bytes.count)),
    		  let ecuVariantName = bytes.extract(stringFrom: (4 + ID.bytes.count + ecuAddress.bytes.count)),
    		  let status = bytes.extract(stringFrom: (6 + ID.bytes.count + ecuAddress.bytes.count + ecuVariantName.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.ID = ID
        self.ecuAddress = ecuAddress
        self.ecuVariantName = ecuVariantName
        self.status = status
    }
}
