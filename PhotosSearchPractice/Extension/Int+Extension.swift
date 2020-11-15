import Foundation

extension Int {

    func int64() -> Int64 {

        return Int64(truncating: NSNumber(integerLiteral: self))
    }
}
