import Foundation

public protocol AAAPICurrent {
    /// Curret level (version) of *AutoAPI* spec (used for this lib generation).
    static var current: UInt8 { get }
}

public extension AAAPICurrent {
    static var current: UInt8 { AAAutoAPI.protocolVersion }
}
