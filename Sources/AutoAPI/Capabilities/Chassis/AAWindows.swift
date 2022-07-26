import Foundation
import HMUtilities

public final class AAWindows: AACapability, AAPropertyIdentifying {
    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAWindows` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAWindows` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0045 }

    /// Property identifiers for `AAWindows`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case openPercentages = 0x02
        case positions = 0x03
    }

    // MARK: Properties
    /// Open percentages value.
    public var openPercentages: [AAProperty<AAWindowOpenPercentage>]?
    
    /// Positions value.
    public var positions: [AAProperty<AAWindowPosition>]?

    // MARK: Getters
    /// Get `AAWindows` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindows() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AAWindows` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindowsProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getWindows() + ids.map { $0.rawValue }
    }
    
    /// Get `AAWindows` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindowsAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AAWindows` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getWindowsPropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getWindowsAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Open or close the windows. Either one or all windows can be controlled with the same command.
    /// 
    /// - parameters:
    ///     - openPercentages: Open percentages value.
    ///     - positions: Positions value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlWindows(openPercentages: [AAWindowOpenPercentage]? = nil, positions: [AAWindowPosition]? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(contentsOf: openPercentages?.compactMap { AAProperty(id: PropertyIdentifier.openPercentages, value: $0) } ?? [])
        properties.append(contentsOf: positions?.compactMap { AAProperty(id: PropertyIdentifier.positions, value: $0) } ?? [])
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        openPercentages = extract(properties: .openPercentages)
        positions = extract(properties: .positions)
    }
}
