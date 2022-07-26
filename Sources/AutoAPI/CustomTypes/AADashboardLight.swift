import Foundation
import HMUtilities

public final class AADashboardLight: Codable, HMBytesConvertable {
    public typealias Name = AADashboardLightName

    /// Name.
    public var name: Name
    /// On-Off State.
    public var state: AAOnOffState

    /// Initialise `AADashboardLight` with arguments.
    ///
    /// - parameters:
    ///     - name: Name.
    ///     - state: On-Off State.
    public init(name: Name, state: AAOnOffState) {
        self.bytes = [name.bytes, state.bytes].flatMap { $0 }
        self.name = name
        self.state = state
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AADashboardLight` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 2 else {
            return nil
        }
    
        guard let name = Name(bytes: bytes[0..<1].bytes),
    		  let state = AAOnOffState(bytes: bytes[1..<2].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.name = name
        self.state = state
    }
}
