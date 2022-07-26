import Foundation
import HMUtilities

public final class AATroubleCode: Codable, HMBytesConvertable {
    public typealias System = AATroubleCodeSystem

    /// Number of occurrences.
    public var occurrences: UInt8
    /// Identifier.
    public var ID: String
    /// Electronic Control Unit identifier.
    public var ecuID: String
    /// Status.
    public var status: String
    /// System.
    public var system: System

    /// Initialise `AATroubleCode` with arguments.
    ///
    /// - parameters:
    ///     - occurrences: Number of occurrences.
    ///     - ID: Identifier.
    ///     - ecuID: Electronic Control Unit identifier.
    ///     - status: Status.
    ///     - system: System.
    public init(occurrences: UInt8, ID: String, ecuID: String, status: String, system: System) {
        self.bytes = [occurrences.bytes, ID.bytes.sizeBytes(amount: 2), ID.bytes, ecuID.bytes.sizeBytes(amount: 2), ecuID.bytes, status.bytes.sizeBytes(amount: 2), status.bytes, system.bytes].flatMap { $0 }
        self.occurrences = occurrences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
        self.system = system
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AATroubleCode` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 2 else {
            return nil
        }
    
        guard let occurrences = UInt8(bytes: bytes[0..<1].bytes),
    		  let ID = bytes.extract(stringFrom: 1),
    		  let ecuID = bytes.extract(stringFrom: (3 + ID.bytes.count)),
    		  let status = bytes.extract(stringFrom: (5 + ID.bytes.count + ecuID.bytes.count)),
    		  let system = System(bytes: bytes[(7 + ID.bytes.count + ecuID.bytes.count + status.bytes.count)..<(8 + ID.bytes.count + ecuID.bytes.count + status.bytes.count)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.occurrences = occurrences
        self.ID = ID
        self.ecuID = ecuID
        self.status = status
        self.system = system
    }
}
