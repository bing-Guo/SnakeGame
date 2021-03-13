import Foundation
import UIKit

struct FoodLayer: SnakeGameViewLayer {
    let size: Int
    var point: Point?
    let color: UIColor

    func generateLayer() -> [CAShapeLayer] {
        guard let point = point else { return [] }

        let shapeLayer = CAShapeLayer()

        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: size, height: size), cornerRadius: 2).cgPath
        shapeLayer.fillColor = color.cgColor

        return [shapeLayer]
    }
}
