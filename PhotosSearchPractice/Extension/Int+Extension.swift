import Foundation

extension Int {

    func int64() -> Int64 {
        // swiftlint:disable compiler_protocol_init
        return Int64(truncating: NSNumber(integerLiteral: self))
        
        // swiftlint:enable compiler_protocol_init
    }
}
