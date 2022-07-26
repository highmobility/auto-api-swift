import Foundation

class AAUnitConverterInverse: UnitConverter {
    var coefficient: Double

    init(coefficient: Double) {
        self.coefficient = coefficient
    }

    // MARK: UnitConverter
    override func baseUnitValue(fromValue value: Double) -> Double {
        coefficient / value
    }

    override func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        coefficient / baseUnitValue
    }
}
