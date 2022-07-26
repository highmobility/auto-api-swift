import Foundation
import HMUtilities

public final class AAWebhook: Codable, HMBytesConvertable {
    public typealias Available = AAWebhookAvailable

    /// If the specified webhook is available..
    public var available: Available
    /// Triggered event.
    public var event: AAEvent

    /// Initialise `AAWebhook` with arguments.
    ///
    /// - parameters:
    ///     - available: If the specified webhook is available..
    ///     - event: Triggered event.
    public init(available: Available, event: AAEvent) {
        self.bytes = [available.bytes, event.bytes].flatMap { $0 }
        self.available = available
        self.event = event
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AAWebhook` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let available = Available(bytes: bytes[0..<1].bytes),
    		  let event = AAEvent(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.available = available
        self.event = event
    }
}
