import Foundation
import HMUtilities

public final class AAChargingLocation: Codable, HMBytesConvertable {
    /// Municipality component of the address.
    public var municipality: String
    /// Full formatted address.
    public var formattedAddress: String
    /// Street address component.
    public var streetAddress: String

    /// Initialise `AAChargingLocation` with arguments.
    ///
    /// - parameters:
    ///     - municipality: Municipality component of the address.
    ///     - formattedAddress: Full formatted address.
    ///     - streetAddress: Street address component.
    public init(municipality: String, formattedAddress: String, streetAddress: String) {
        self.bytes = [municipality.bytes.sizeBytes(amount: 2), municipality.bytes, formattedAddress.bytes.sizeBytes(amount: 2), formattedAddress.bytes, streetAddress.bytes.sizeBytes(amount: 2), streetAddress.bytes].flatMap { $0 }
        self.municipality = municipality
        self.formattedAddress = formattedAddress
        self.streetAddress = streetAddress
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAChargingLocation` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 0 else {
            return nil
        }
    
        guard let municipality = bytes.extract(stringFrom: 0),
    		  let formattedAddress = bytes.extract(stringFrom: (2 + municipality.bytes.count)),
    		  let streetAddress = bytes.extract(stringFrom: (4 + municipality.bytes.count + formattedAddress.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.municipality = municipality
        self.formattedAddress = formattedAddress
        self.streetAddress = streetAddress
    }
}
