import Foundation
import HMUtilities

public final class AAChargingCost: Codable, HMBytesConvertable {
    /// Currency ISO code.
    public var currency: String
    /// Calculated charging cost.
    public var calculatedChargingCost: Double
    /// Calculated savings from charging.
    public var calculatedSavings: Double
    /// Simulated charging costs.
    public var simulatedImmediateChargingCost: Double

    /// Initialise `AAChargingCost` with arguments.
    ///
    /// - parameters:
    ///     - currency: Currency ISO code.
    ///     - calculatedChargingCost: Calculated charging cost.
    ///     - calculatedSavings: Calculated savings from charging.
    ///     - simulatedImmediateChargingCost: Simulated charging costs.
    public init(currency: String, calculatedChargingCost: Double, calculatedSavings: Double, simulatedImmediateChargingCost: Double) {
        self.bytes = [currency.bytes.sizeBytes(amount: 2), currency.bytes, calculatedChargingCost.bytes, calculatedSavings.bytes, simulatedImmediateChargingCost.bytes].flatMap { $0 }
        self.currency = currency
        self.calculatedChargingCost = calculatedChargingCost
        self.calculatedSavings = calculatedSavings
        self.simulatedImmediateChargingCost = simulatedImmediateChargingCost
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAChargingCost` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 24 else {
            return nil
        }
    
        guard let currency = bytes.extract(stringFrom: 0),
    		  let calculatedChargingCost = Double(bytes: bytes[(2 + currency.bytes.count)..<(10 + currency.bytes.count)].bytes),
    		  let calculatedSavings = Double(bytes: bytes[(10 + currency.bytes.count)..<(18 + currency.bytes.count)].bytes),
    		  let simulatedImmediateChargingCost = Double(bytes: bytes[(18 + currency.bytes.count)..<(26 + currency.bytes.count)].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.currency = currency
        self.calculatedChargingCost = calculatedChargingCost
        self.calculatedSavings = calculatedSavings
        self.simulatedImmediateChargingCost = simulatedImmediateChargingCost
    }
}
