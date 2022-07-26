import Foundation
import HMUtilities

public extension AAOpaqueProperty {

    /// The main component used to transmit values.
    var data: [UInt8]? {
        [UInt8](bytes: components.first(type: .data)?.value)
    }

    /// The timestamp (when the data was created) of the property.
    var timestamp: Date? {
        Date(bytes: components.first(type: .timestamp)?.value)
    }

    /// Information about why retrieving a property failed.
    var failure: AAFailure? {
        AAFailure(bytes: components.first(type: .failure)?.value)
    }

    /// Availability value.
    var availability: AAAvailability? {
        AAAvailability(bytes: components.first(type: .availability)?.value)
    }
}
