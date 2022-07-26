import Foundation

public class UnitTorque: Dimension {
    public static let newtonMeters = UnitTorque(symbol: "hm_nm", converter: UnitConverterLinear(coefficient: 1.0))
    public static let newtonMillimeters = UnitTorque(symbol: "hm_nms", converter: UnitConverterLinear(coefficient: 0.001))
    public static let poundFeet = UnitTorque(symbol: "hm_pf", converter: UnitConverterLinear(coefficient: 0.73756214927727))
    public static let baseUnit = newtonMeters
}
