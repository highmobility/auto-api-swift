import Foundation
import HMUtilities

public final class AARGBColour: Codable, HMBytesConvertable {
    /// The red component of RGB.
    public var red: UInt8
    /// The green component of RGB.
    public var green: UInt8
    /// The blue component of RGB.
    public var blue: UInt8

    /// Initialise `AARGBColour` with arguments.
    ///
    /// - parameters:
    ///     - red: The red component of RGB.
    ///     - green: The green component of RGB.
    ///     - blue: The blue component of RGB.
    public init(red: UInt8, green: UInt8, blue: UInt8) {
        self.bytes = [red.bytes, green.bytes, blue.bytes].flatMap { $0 }
        self.red = red
        self.green = green
        self.blue = blue
    }

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]
    
    /// Initialise `AARGBColour` with bytes.
    ///
    /// - parameters:
    ///     - bytes: Bytes array in `[UInt8]`.
    public required init?(bytes: [UInt8]) {
        guard bytes.count == 3 else {
            return nil
        }
    
        guard let red = UInt8(bytes: bytes[0..<1].bytes),
    		  let green = UInt8(bytes: bytes[1..<2].bytes),
    		  let blue = UInt8(bytes: bytes[2..<3].bytes) else {
            return nil
        }
    
        self.bytes = bytes
        self.red = red
        self.green = green
        self.blue = blue
    }
}
