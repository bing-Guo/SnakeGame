import Foundation
import UIKit

struct BackgroundLayer: SnakeGameViewLayer {
    let size: Int
    var area: Area
    let oddColor: UIColor
    let evenColor: UIColor

    func generateLayer() -> [CAShapeLayer] {
        let oddShapeLayer = CAShapeLayer()
        let evenShapeLayer = CAShapeLayer()

        let oddPath = UIBezierPath()
        let evenPath = UIBezierPath()

        let point2D = generateGridPoints(maxX: area.rightBottom.x, maxY: area.rightBottom.y, size: size)

        for (row, points) in point2D.enumerated() {
            let offset = (row % 2 == 0) ? 0 : 1

            for (col, point) in points.enumerated() {
                if col % 2 == offset {
                    let path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: size, height: size), cornerRadius: 2)
                    evenPath.append(path)
                } else {
                    let path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: size, height: size), cornerRadius: 2)
                    oddPath.append(path)
                }
            }
        }

        oddShapeLayer.path = oddPath.cgPath
        oddShapeLayer.fillColor = oddColor.cgColor
        evenShapeLayer.path = oddPath.cgPath
        evenShapeLayer.fillColor = evenColor.cgColor

        return [oddShapeLayer, evenShapeLayer]
    }

    private func generateGridPoints(maxX: Int, maxY: Int, size: Int) -> [[Point]] {
        var points = [[Point]]()

        for y in stride(from: 0, to: maxY, by: size) {
            var temp = [Point]()

            for x in stride(from: 0, to: maxX, by: size) {
                temp.append(Point(x: x, y: y))
            }

            points.append(temp)
        }

        return points
    }
}
