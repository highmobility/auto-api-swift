import Foundation
import HMUtilities

public final class AAParkAssist: Codable, HMBytesConvertable {
    /// Location longitudinal.
    public var location: AALocationLongitudinal
    /// Active state.
    public var alarm: AAActiveState
    /// Muted.
    public var muted: AAMuted

    /// Initialise `AAParkAssist` with arguments.
    ///
    /// - parameters:
    ///     - location: Location longitudinal.
    ///     - alarm: Active state.
    ///     - muted: Muted.
    public init(location: AALocationLongitudinal, alarm: AAActiveState, muted: AAMuted) {
        self.bytes = [location.bytes, alarm.bytes, muted.bytes].flatMap { $0 }
        self.location = location
        self.alarm = alarm
        self.muted = muted
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAParkAssist` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let location = AALocationLongitudinal(bytes: bytes[0..<1].bytes),
    		  let alarm = AAActiveState(bytes: bytes[1..<2].bytes),
    		  let muted = AAMuted(bytes: bytes[2..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.alarm = alarm
        self.muted = muted
    }
}
