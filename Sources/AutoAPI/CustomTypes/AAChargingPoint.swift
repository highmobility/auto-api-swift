import Foundation
import HMUtilities

public final class AAChargingPoint: Codable, HMBytesConvertable {
    /// City the charging point is in..
    public var city: String
    /// Postal code the charging point is at..
    public var postalCode: String
    /// Street address the chargin point is at..
    public var street: String
    /// The provider name of the charging point..
    public var provider: String

    /// Initialise `AAChargingPoint` with arguments.
    ///
    /// - parameters:
    ///     - city: City the charging point is in..
    ///     - postalCode: Postal code the charging point is at..
    ///     - street: Street address the chargin point is at..
    ///     - provider: The provider name of the charging point..
    public init(city: String, postalCode: String, street: String, provider: String) {
        self.bytes = [city.bytes.sizeBytes(amount: 2), city.bytes, postalCode.bytes.sizeBytes(amount: 2), postalCode.bytes, street.bytes.sizeBytes(amount: 2), street.bytes, provider.bytes.sizeBytes(amount: 2), provider.bytes].flatMap { $0 }
        self.city = city
        self.postalCode = postalCode
        self.street = street
        self.provider = provider
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAChargingPoint` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 0 else {
            return nil
        }
    
        guard let city = bytes.extract(stringFrom: 0),
    		  let postalCode = bytes.extract(stringFrom: (2 + city.bytes.count)),
    		  let street = bytes.extract(stringFrom: (4 + city.bytes.count + postalCode.bytes.count)),
    		  let provider = bytes.extract(stringFrom: (6 + city.bytes.count + postalCode.bytes.count + street.bytes.count)) else {
            return nil
        }
    
        self.bytes = bytes
        self.city = city
        self.postalCode = postalCode
        self.street = street
        self.provider = provider
    }
}
