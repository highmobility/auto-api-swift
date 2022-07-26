import Foundation
import HMUtilities

public final class AABrakeServiceStatus: Codable, HMBytesConvertable {
    /// Axle.
    public var axle: AAAxle
    /// Service-Status.
    public var status: AAServiceStatus

    /// Initialise `AABrakeServiceStatus` with arguments.
    ///
    /// - parameters:
    ///     - axle: Axle.
    ///     - status: Service-Status.
    public init(axle: AAAxle, status: AAServiceStatus) {
        self.bytes = [axle.bytes, status.bytes].flatMap { $0 }
        self.axle = axle
        self.status = status
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AABrakeServiceStatus` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let axle = AAAxle(bytes: bytes[0..<1].bytes),
    		  let status = AAServiceStatus(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.axle = axle
        self.status = status
    }
}
