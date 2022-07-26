import Foundation
import HMUtilities

public final class AAPriceTariff: Codable, HMBytesConvertable {
    public typealias PricingType = AAPriceTariffPricingType

    /// PricingType.
    public var pricingType: PricingType
    /// The price.
    public var price: Double
    /// The currency alphabetic code per ISO 4217 or crypto currency symbol.
    public var currency: String

    /// Initialise `AAPriceTariff` with arguments.
    ///
    /// - parameters:
    ///     - pricingType: PricingType.
    ///     - price: The price.
    ///     - currency: The currency alphabetic code per ISO 4217 or crypto currency symbol.
    public init(pricingType: PricingType, price: Double, currency: String) {
        self.bytes = [pricingType.bytes, price.bytes, currency.bytes.sizeBytes(amount: 2), currency.bytes].flatMap { $0 }
        self.pricingType = pricingType
        self.price = price
        self.currency = currency
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAPriceTariff` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 9 else {
            return nil
        }
    
        guard let pricingType = PricingType(bytes: bytes[0..<1].bytes),
    		  let price = Double(bytes: bytes[1..<9].bytes),
    		  let currency = bytes.extract(stringFrom: 9) else {
            return nil
        }
    
        self.bytes = bytes
        self.pricingType = pricingType
        self.price = price
        self.currency = currency
    }
}
