import Foundation
import HMUtilities

public final class AALights: AACapability, AAPropertyIdentifying {
    public typealias FrontExteriorLight = AALightsFrontExteriorLight
    public typealias SwitchPosition = AALightsSwitchPosition
    public typealias ParkingLightStatus = AALightsParkingLightStatus

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AALights` was introduced to the spec.
        public static let intro: UInt8 = 3
    
        /// Level (version) of *AutoAPI* when `AALights` was last updated.
        public static let updated: UInt8 = 12
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0036 }

    /// Property identifiers for `AALights`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case frontExteriorLight = 0x01
        case rearExteriorLight = 0x02
        case ambientLightColour = 0x04
        case reverseLight = 0x05
        case emergencyBrakeLight = 0x06
        case fogLights = 0x07
        case readingLamps = 0x08
        case interiorLights = 0x09
        case switchPosition = 0x0a
        case parkingLightStatus = 0x0b
    }

    // MARK: Properties
    /// Ambient light colour value.
    public var ambientLightColour: AAProperty<AARGBColour>?
    
    /// Emergency brake light value.
    public var emergencyBrakeLight: AAProperty<AAActiveState>?
    
    /// Fog lights value.
    public var fogLights: [AAProperty<AALight>]?
    
    /// Front exterior light value.
    public var frontExteriorLight: AAProperty<FrontExteriorLight>?
    
    /// Interior lights value.
    public var interiorLights: [AAProperty<AALight>]?
    
    /// Indicates the status of the parking light..
    public var parkingLightStatus: AAProperty<ParkingLightStatus>?
    
    /// Reading lamps value.
    public var readingLamps: [AAProperty<AAReadingLamp>]?
    
    /// Rear exterior light value.
    public var rearExteriorLight: AAProperty<AAActiveState>?
    
    /// Reverse light value.
    public var reverseLight: AAProperty<AAActiveState>?
    
    /// Position of the rotary light switch.
    public var switchPosition: AAProperty<SwitchPosition>?

    // MARK: Getters
    /// Get `AALights` state (all properties).
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightsState() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.get.rawValue.bytes
    }
    
    /// Get `AALights` state's specific properties.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightsStateProperties(ids: PropertyIdentifier...) -> [UInt8] {
        getLightsState() + ids.map { $0.rawValue }
    }
    
    /// Get `AALights` state properties availability.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightsStateAvailability() -> [UInt8] {
        AAAutoAPI.protocolVersion.bytes + Self.identifier.bytes + AACommandType.availability.rawValue.bytes
    }
    
    /// Get `AALights` state's specific properties' availability.
    ///
    /// - parameters:
    ///     - ids: List of property identifiers to request availability for.
    ///
    /// - returns: The request as `[UInt8]` to send to the vehicle.
    public static func getLightsStatePropertiesAvailability(ids: PropertyIdentifier...) -> [UInt8] {
        getLightsStateAvailability() + ids.map { $0.rawValue }
    }

    // MARK: Setters
    /// Set the lights state.
    /// 
    /// - parameters:
    ///     - frontExteriorLight: Front exterior light value.
    ///     - rearExteriorLight: Rear exterior light value.
    ///     - ambientLightColour: Ambient light colour value.
    ///     - fogLights: Fog lights value.
    ///     - readingLamps: Reading lamps value.
    ///     - interiorLights: Interior lights value.
    ///
    /// - returns: Command as `[UInt8]` to send to the vehicle.
    public static func controlLights(frontExteriorLight: FrontExteriorLight? = nil, rearExteriorLight: AAActiveState? = nil, ambientLightColour: AARGBColour? = nil, fogLights: [AALight]? = nil, readingLamps: [AAReadingLamp]? = nil, interiorLights: [AALight]? = nil) -> [UInt8] {
        var properties: [AAOpaqueProperty?] = []
    
        properties.append(AAProperty(id: PropertyIdentifier.frontExteriorLight, value: frontExteriorLight))
        properties.append(AAProperty(id: PropertyIdentifier.rearExteriorLight, value: rearExteriorLight))
        properties.append(AAProperty(id: PropertyIdentifier.ambientLightColour, value: ambientLightColour))
        properties.append(contentsOf: fogLights?.compactMap { AAProperty(id: PropertyIdentifier.fogLights, value: $0) } ?? [])
        properties.append(contentsOf: readingLamps?.compactMap { AAProperty(id: PropertyIdentifier.readingLamps, value: $0) } ?? [])
        properties.append(contentsOf: interiorLights?.compactMap { AAProperty(id: PropertyIdentifier.interiorLights, value: $0) } ?? [])
    
        let propertiesBytes = properties.compactMap { $0 }.sorted { $0.id < $1.id }.flatMap { $0.bytes }
    
        return setterHeader + propertiesBytes
    }

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        ambientLightColour = extract(property: .ambientLightColour)
        emergencyBrakeLight = extract(property: .emergencyBrakeLight)
        fogLights = extract(properties: .fogLights)
        frontExteriorLight = extract(property: .frontExteriorLight)
        interiorLights = extract(properties: .interiorLights)
        parkingLightStatus = extract(property: .parkingLightStatus)
        readingLamps = extract(properties: .readingLamps)
        rearExteriorLight = extract(property: .rearExteriorLight)
        reverseLight = extract(property: .reverseLight)
        switchPosition = extract(property: .switchPosition)
    }
}
