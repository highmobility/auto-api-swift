import Foundation
import HMUtilities

public final class AAEcoDrivingThreshold: Codable, HMBytesConvertable {
    public typealias TypeOf = AAEcoDrivingThresholdType

    /// Type.
    public var type: TypeOf
    /// Value.
    public var value: Double

    /// Initialise `AAEcoDrivingThreshold` with arguments.
    ///
    /// - parameters:
    ///     - type: Type.
    ///     - value: Value.
    public init(type: TypeOf, value: Double) {
        self.bytes = [type.bytes, value.bytes].flatMap { $0 }
        self.type = type
        self.value = value
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAEcoDrivingThreshold` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 9 else {
            return nil
        }
    
        guard let type = TypeOf(bytes: bytes[0..<1].bytes),
    		  let value = Double(bytes: bytes[1..<9].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.type = type
        self.value = value
    }
}
