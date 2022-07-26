import Foundation
import HMUtilities

public final class AAVideoHandover: AACapability, AAPropertyIdentifying {
    public typealias Screen = AAVideoHandoverScreen

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAVideoHandover` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAVideoHandover` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0043 }

    /// Property identifiers for `AAVideoHandover`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case url = 0x01		// Non-state property (can't be retrieved)
        case screen = 0x03		// Non-state property (can't be retrieved)
        case startingTime = 0x04		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Hand over a video from smart device to vehicle headunit to be shown in the vehicle display. The emulator supports HTML5 video player formats .mp4 and .webm.
    /// 
    /// - parameters:
    ///     - url: URL string.
    ///     - screen: Screen value.
    ///     - startingTime: Start the video from the given time.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func videoHandover(url: String, screen: Screen? = nil, startingTime: Measurement<UnitDuration>? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.url, value: url))
        properties.append(AAProperty(id: PropertyIdentifier.screen, value: screen))
        properties.append(AAProperty(id: PropertyIdentifier.startingTime, value: startingTime))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
