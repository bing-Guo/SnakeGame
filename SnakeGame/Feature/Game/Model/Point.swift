import Foundation

struct Point {
    let x: Int
    let y: Int
}

extension Point: Equatable {}

extension Point: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}
