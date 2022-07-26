import Foundation
import HMUtilities

public final class AABrowser: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AABrowser` was introduced to the spec.
        public static let intro: UInt8 = 4
    
        /// Level (version) of *AutoAPI* when `AABrowser` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0049 }

    /// Property identifiers for `AABrowser`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case url = 0x01		// Non-state property (can't be retrieved)
    }

    // MARK: Setters
    /// Load a URL in the headunit browser. A URL shortener can be used in other cases. Note that for the vehicle emulator the URL has to be for a secure site (HTTPS).
    /// 
    /// - parameters:
    ///     - url: The URL.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func loadUrl(url: String) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.url, value: url))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }
}
