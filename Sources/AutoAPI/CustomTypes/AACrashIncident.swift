import Foundation
import HMUtilities

public final class AACrashIncident: Codable, HMBytesConvertable {
    public typealias Location = AACrashIncidentLocation
    public typealias Severity = AACrashIncidentSeverity
    public typealias Repairs = AACrashIncidentRepairs

    /// Location.
    public var location: Location
    /// Severity.
    public var severity: Severity
    /// Repairs.
    public var repairs: Repairs

    /// Initialise `AACrashIncident` with arguments.
    ///
    /// - parameters:
    ///     - location: Location.
    ///     - severity: Severity.
    ///     - repairs: Repairs.
    public init(location: Location, severity: Severity, repairs: Repairs) {
        self.bytes = [location.bytes, severity.bytes, repairs.bytes].flatMap { $0 }
        self.location = location
        self.severity = severity
        self.repairs = repairs
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AACrashIncident` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let location = Location(bytes: bytes[0..<1].bytes),
    		  let severity = Severity(bytes: bytes[1..<2].bytes),
    		  let repairs = Repairs(bytes: bytes[2..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.location = location
        self.severity = severity
        self.repairs = repairs
    }
}
