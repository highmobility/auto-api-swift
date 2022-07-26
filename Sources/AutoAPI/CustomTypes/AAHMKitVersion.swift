import Foundation
import HMUtilities

public final class AAHMKitVersion: Codable, HMBytesConvertable {
    /// HMKit version major number.
    public var major: UInt8
    /// HMKit version minor number.
    public var minor: UInt8
    /// HMKit version patch number.
    public var patch: UInt8

    /// Initialise `AAHMKitVersion` with arguments.
    ///
    /// - parameters:
    ///     - major: HMKit version major number.
    ///     - minor: HMKit version minor number.
    ///     - patch: HMKit version patch number.
    public init(major: UInt8, minor: UInt8, patch: UInt8) {
        self.bytes = [major.bytes, minor.bytes, patch.bytes].flatMap { $0 }
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAHMKitVersion` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let major = UInt8(bytes: bytes[0..<1].bytes),
    		  let minor = UInt8(bytes: bytes[1..<2].bytes),
    		  let patch = UInt8(bytes: bytes[2..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}
