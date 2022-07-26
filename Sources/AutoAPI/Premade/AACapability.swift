import Foundation
import HMUtilities

public class AACapability: Encodable, HMBytesConvertable {
    class var identifier: UInt16 { 0x0000 }

    public let properties: [AAOpaqueProperty]

    // MARK: HMBytesConvertable
    public let bytes: [UInt8]

    public required init?(bytes: [UInt8]) {
        guard bytes.count >= 4,
            bytes[3] == AACommandType.set.rawValue else {
                return nil
        }

        // Verify the ID (again)
        guard Self.identifier == UInt16(bytes: bytes[1...2])! else {
            return nil
        }

        self.bytes = bytes
        self.properties = bytes.suffix(from: 4).bytes.generateProperties()
    }
}

extension AACapability {
    static var setterHeader: [UInt8] {
        AAAutoAPI.protocolVersion.bytes +
            Self.identifier.bytes +
            AACommandType.set.rawValue.bytes
    }
}
