import Foundation
import UIKit

extension UISwipeGestureRecognizer.Direction {
    func asDirection() -> Direction {
        switch self {
        case .up:
            return .up
        case .left:
            return .left
        case .right:
            return .right
        case .down:
            return .down
        default:
            return .up
        }
    }
}
