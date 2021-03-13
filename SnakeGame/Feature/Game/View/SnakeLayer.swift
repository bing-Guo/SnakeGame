import Foundation
import UIKit

struct SnakeLayer: SnakeGameViewLayer {
    let size: Int
    let points: [Point]
    let color: UIColor

    func generateLayer() -> [CAShapeLayer] {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        for point in points {
            path.append(UIBezierPath(rect: CGRect(x: point.x, y: point.y, width: size, height: size)))
        }

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = color.cgColor

        return [shapeLayer]
    }
}
