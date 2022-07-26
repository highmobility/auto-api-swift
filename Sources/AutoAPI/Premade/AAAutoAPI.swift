import Foundation
import HMUtilities

public struct AAAutoAPI {
    /// Parse bytes `[UInt8]` to a capability.
    ///
    /// This is the *main* access point for parsing data into an easily usable capability.
    ///
    /// After a capability is parsed, it should be cast into the desired type.
    ///
    /// ```
    /// if let charging = AAAutoAPI.parseBytes(bytes) as? AACharging {
    ///     // code
    /// }
    /// ```
    ///
    /// - parameters:
    ///    - bytes: Bytes of a capability's *state* in `[UInt8]`
    ///
    /// - returns: The parsed capability (if a match is found) as `AACapability`
    public static func parseBytes(_ bytes: [UInt8]) throws -> AACapability? {
        guard bytes.count >= 4 else {
            throw AAError.insufficientBytes
        }

        // Check if the data is for the correct version
        guard bytes[0] == protocolVersion else {
            throw AAError.invalidVersion
        }

        let capabilityID = UInt16(bytes: bytes[1...2])!

        return capabilities.first { $0.identifier == capabilityID }?.init(bytes: bytes)
    }
}
