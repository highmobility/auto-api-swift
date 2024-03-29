import Foundation
import HMUtilities

public final class AARooftopControl: AACapability, AAPropertyIdentifying {
    public typealias ConvertibleRoofState = AARooftopControlConvertibleRoofState
    public typealias SunroofTiltState = AARooftopControlSunroofTiltState
    public typealias SunroofState = AARooftopControlSunroofState
    public typealias SunroofRainEvent = AARooftopControlSunroofRainEvent

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AARooftopControl` was introduced to the spec.
        public static let intro: UInt8 = 3
    
        /// Level (version) of *AutoAPI* when `AARooftopControl` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0025 }

    /// Property identifiers for `AARooftopControl`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case dimming = 0x01
        case position = 0x02
        case convertibleRoofState = 0x03
        case sunroofTiltState = 0x04
        case sunroofState = 0x05
        case sunroofRainEvent = 0x06
        case tiltPosition = 0x07
    }

    // MARK: Properties
    /// Convertible roof state value.
    public var convertibleRoofState: AAProperty<ConvertibleRoofState>?
    
    /// 1.0 (100%) is opaque, 0.0 (0%) is transparent.
    public var dimming: AAProperty<AAPercentage>?
    
    /// 1.0 (100%) is fully open, 0.0 (0%) is closed.
    public var position: AAProperty<AAPercentage>?
    
    /// Sunroof event happened in case of rain.
    public var sunroofRainEvent: AAProperty<SunroofRainEvent>?
    
    /// Sunroof state value.
    public var sunroofState: AAProperty<SunroofState>?
    
    /// Sunroof tilt state value.
    public var sunroofTiltState: AAProperty<SunroofTiltState>?
    
    /// 1.0 (100%) is fully tilted, 0.0 (0%) is not.
    public var tiltPosition: AAProperty<AAPercentage>?

    // MARK: Getters
    /// Get `AARooftopControl` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRooftopState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AARooftopControl` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRooftopStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getRooftopState() + ids.map { $0.rawValue }
    }
    
    /// Get `AARooftopControl` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRooftopStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AARooftopControl` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getRooftopStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getRooftopStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the rooftop state.
    /// 
    /// - parameters:
    ///     - dimming: 1.0 (100%) is opaque, 0.0 (0%) is transparent.
    ///     - position: 1.0 (100%) is fully open, 0.0 (0%) is closed.
    ///     - convertibleRoofState: Convertible roof state value.
    ///     - sunroofTiltState: Sunroof tilt state value.
    ///     - sunroofState: Sunroof state value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlRooftop(dimming: AAPercentage? = nil, position: AAPercentage? = nil, convertibleRoofState: ConvertibleRoofState? = nil, sunroofTiltState: SunroofTiltState? = nil, sunroofState: SunroofState? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.dimming, value: dimming))
        properties.append(AAProperty(id: PropertyIdentifier.position, value: position))
        properties.append(AAProperty(id: PropertyIdentifier.convertibleRoofState, value: convertibleRoofState))
        properties.append(AAProperty(id: PropertyIdentifier.sunroofTiltState, value: sunroofTiltState))
        properties.append(AAProperty(id: PropertyIdentifier.sunroofState, value: sunroofState))
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        convertibleRoofState = extract(property: .convertibleRoofState)
        dimming = extract(property: .dimming)
        position = extract(property: .position)
        sunroofRainEvent = extract(property: .sunroofRainEvent)
        sunroofState = extract(property: .sunroofState)
        sunroofTiltState = extract(property: .sunroofTiltState)
        tiltPosition = extract(property: .tiltPosition)
    }
}
