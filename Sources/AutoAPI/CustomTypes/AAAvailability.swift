import Foundation
import HMUtilities

public final class AAAvailability: Codable, HMBytesConvertable {
    public typealias UpdateRate = AAAvailabilityUpdateRate
    public typealias AppliesPer = AAAvailabilityAppliesPer

    /// Update rate.
    public var updateRate: UpdateRate
    /// Frequency denoting the rate limit.
    public var rateLimit: Measurement<UnitFrequency>
    /// Rate limit applies per.
    public var appliesPer: AppliesPer

    /// Initialise `AAAvailability` with arguments.
    ///
    /// - parameters:
    ///     - updateRate: Update rate.
    ///     - rateLimit: Frequency denoting the rate limit.
    ///     - appliesPer: Rate limit applies per.
    public init(updateRate: UpdateRate, rateLimit: Measurement<UnitFrequency>, appliesPer: AppliesPer) {
        self.bytes = [updateRate.bytes, rateLimit.bytes, appliesPer.bytes].flatMap { $0 }
        self.updateRate = updateRate
        self.rateLimit = rateLimit
        self.appliesPer = appliesPer
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAAvailability` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 12 else {
            return nil
        }
    
        guard let updateRate = UpdateRate(bytes: bytes[0..<1].bytes),
    		  let rateLimit = Measurement<UnitFrequency>(bytes: bytes[1..<(1 + 10)].bytes),
    		  let appliesPer = AppliesPer(bytes: bytes[11..<12].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.updateRate = updateRate
        self.rateLimit = rateLimit
        self.appliesPer = appliesPer
    }
}
