import Foundation
import HMUtilities

public final class AAChargingRestriction: Codable, HMBytesConvertable {
    public typealias Limit = AAChargingRestrictionLimit

    /// Indicates whether the charging current used to charge the vehicle is limited..
    public var active: AAActiveState
    /// Limit.
    public var limit: Limit

    /// Initialise `AAChargingRestriction` with arguments.
    ///
    /// - parameters:
    ///     - active: Indicates whether the charging current used to charge the vehicle is limited..
    ///     - limit: Limit.
    public init(active: AAActiveState, limit: Limit) {
        self.bytes = [active.bytes, limit.bytes].flatMap { $0 }
        self.active = active
        self.limit = limit
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAChargingRestriction` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let active = AAActiveState(bytes: bytes[0..<1].bytes),
    		  let limit = Limit(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.active = active
        self.limit = limit
    }
}
