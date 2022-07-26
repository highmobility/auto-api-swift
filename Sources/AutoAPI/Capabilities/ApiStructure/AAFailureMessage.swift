import Foundation
import HMUtilities

public final class AAFailureMessage: AACapability, AAPropertyIdentifying {
    public typealias FailureReason = AAFailureMessageFailureReason

    /// Information about the introduction and last update of this capability.
    public enum API: AAAPICurrent {
        /// Level (version) of *AutoAPI* when `AAFailureMessage` was introduced to the spec.
        public static let intro: UInt8 = 2
    
        /// Level (version) of *AutoAPI* when `AAFailureMessage` was last updated.
        public static let updated: UInt8 = 11
    }

    // MARK: Identifiers
    public class override var identifier: UInt16 { 0x0002 }

    /// Property identifiers for `AAFailureMessage`.
    public enum PropertyIdentifier: UInt8, CaseIterable {
        case failedMessageID = 0x01
        case failedMessageType = 0x02
        case failureReason = 0x03
        case failureDescription = 0x04
        case failedPropertyIDs = 0x05
    }

    // MARK: Properties
    /// Capability identifier of the failed message.
    public var failedMessageID: AAProperty<UInt16>?
    
    /// Message type of the failed message.
    public var failedMessageType: AAProperty<UInt8>?
    
    /// Array of failed property identifiers.
    public var failedPropertyIDs: AAProperty<[UInt8]>?
    
    /// Failure description.
    public var failureDescription: AAProperty<String>?
    
    /// Failure reason value.
    public var failureReason: AAProperty<FailureReason>?

    // MARK: AACapability
    public required init?(bytes: [UInt8]) {
        super.init(bytes: bytes)
    
        failedMessageID = extract(property: .failedMessageID)
        failedMessageType = extract(property: .failedMessageType)
        failedPropertyIDs = extract(property: .failedPropertyIDs)
        failureDescription = extract(property: .failureDescription)
        failureReason = extract(property: .failureReason)
    }
}
