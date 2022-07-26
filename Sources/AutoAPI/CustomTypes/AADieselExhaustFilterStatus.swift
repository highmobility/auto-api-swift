import Foundation
import HMUtilities

public final class AADieselExhaustFilterStatus: Codable, HMBytesConvertable {
    public typealias Status = AADieselExhaustFilterStatusStatus
    public typealias Component = AADieselExhaustFilterStatusComponent
    public typealias Cleaning = AADieselExhaustFilterStatusCleaning

    /// Status.
    public var status: Status
    /// Component.
    public var component: Component
    /// Cleaning.
    public var cleaning: Cleaning

    /// Initialise `AADieselExhaustFilterStatus` with arguments.
    ///
    /// - parameters:
    ///     - status: Status.
    ///     - component: Component.
    ///     - cleaning: Cleaning.
    public init(status: Status, component: Component, cleaning: Cleaning) {
        self.bytes = [status.bytes, component.bytes, cleaning.bytes].flatMap { $0 }
        self.status = status
        self.component = component
        self.cleaning = cleaning
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADieselExhaustFilterStatus` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let status = Status(bytes: bytes[0..<1].bytes),
    		  let component = Component(bytes: bytes[1..<2].bytes),
    		  let cleaning = Cleaning(bytes: bytes[2..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.status = status
        self.component = component
        self.cleaning = cleaning
    }
}
