import Foundation

public class UnitAngularVelocity: Dimension {
    public static let revolutionsPerMinute = UnitAngularVelocity(symbol: "hm_rpm", converter: UnitConverterLinear(coefficient: 1.0))
    public static let degreesPerSecond = UnitAngularVelocity(symbol: "hm_dps", converter: UnitConverterLinear(coefficient: 6.0))
    public static let radiansPerSecond = UnitAngularVelocity(symbol: "hm_rps", converter: UnitConverterLinear(coefficient: 9.549296585514))
    public static let baseUnit = revolutionsPerMinute
}
