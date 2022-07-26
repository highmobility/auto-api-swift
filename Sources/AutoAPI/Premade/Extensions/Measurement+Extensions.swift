import Foundation
import HMUtilities

extension Measurement: HMBytesConvertable where UnitType: AAUnitType {
    public var bytes: [UInt8] {
        if let ids = unit.identifiers {
            return ids + value.bytes
        }
        else {
            return converted(to: type(of: unit).baseUnit() ).bytes
        }
    }

    public init?(bytes: [UInt8]) {
        guard bytes.count >= 10 else {
            return nil
        }

        let msrByte = bytes[0]
        let unitByte = bytes[1]
        let valBytes = bytes[2..<10]

        guard let val = Double(bytes: valBytes),
            let msrType = AAMeasurement.types.first(where: { $0.measurementID == msrByte }),
            let unit = msrType.create(id: unitByte) else {
                return nil
        }

        self = Measurement(value: val, unit: unit as! UnitType)
    }
}
