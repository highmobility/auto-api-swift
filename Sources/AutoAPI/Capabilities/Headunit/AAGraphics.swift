import Foundation
import HMUtilities

public final class AAGraphics: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAGraphics` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AAGraphics` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0051 }

    /// Property identifiers for `AAGraphics`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case imageURL = 0x01		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Display an image in the headunit by providing the image URL.
    /// 
    /// - parameters:
    ///     - imageURL: The image URL.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func displayImage(imageURL: String) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.imageURL, value: imageURL))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
