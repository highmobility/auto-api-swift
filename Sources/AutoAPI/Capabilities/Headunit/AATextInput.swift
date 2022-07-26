import Foundation
import HMUtilities

public final class AATextInput: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AATextInput` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AATextInput` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0044 }

    /// Property identifiers for `AATextInput`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case text = 0x01		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Send a keystroke or entire sentences as input to the vehicle headunit. This can act as an alternative to the input devices that the vehicle is equipped with.
    /// 
    /// - parameters:
    ///     - text: The text.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func textInput(text: String) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.text, value: text))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
