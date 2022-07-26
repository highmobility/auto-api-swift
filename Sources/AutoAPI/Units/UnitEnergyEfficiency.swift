import Foundation

public class UnitEnergyEfficiency: Dimension {
    public static let kwhPer100Kilometers = UnitEnergyEfficiency(symbol: "hm_kp1k", converter: AAUnitConverterInverse(coefficient: 1.0))
    public static let milesPerKwh = UnitEnergyEfficiency(symbol: "hm_mpk", converter: AAUnitConverterInverse(coefficient: 62.1371192237334))
    public static let baseUnit = kwhPer100Kilometers
}
