import Foundation

public extension AACapability {
    typealias Brand = AABrand

    var nonce: AAProperty<[UInt8]>? {
        properties.property(id: AAUniversalPropertyType.nonce)
    }

    var vehicleSignature: AAProperty<[UInt8]>? {
        properties.property(id: AAUniversalPropertyType.vehicleSignature)
    }

    var timestamp: AAProperty<Date>? {
        properties.property(id: AAUniversalPropertyType.timestamp)
    }

    var vin: AAProperty<String>? {
        properties.property(id: AAUniversalPropertyType.vin)
    }

    var brand: AAProperty<Brand>? {
        properties.property(id: AAUniversalPropertyType.brand)
    }
}
