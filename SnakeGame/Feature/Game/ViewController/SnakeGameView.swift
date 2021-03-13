import Foundation
import UIKit

protocol SnakeGameProtocol: NSObject {
    func getArea() -> Area
    func getUnit() -> Int
    func getSnakePath() -> [Point]
    func getFoodPosition() -> Point
}

class SnakeGameView: UIView {
    weak var delegate: SnakeGameProtocol?

    var snakeColor = UIColor(rgb: 0x2E8ED4)
    var foodColor = UIColor(rgb: 0xB8211A)
    var oddGridColor = UIColor(rgb: 0x1F2C37)
    var evenGridColor = UIColor(rgb: 0x253645)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let delegate = delegate else { return }

        let size = delegate.getUnit()
        let area = delegate.getArea()
        let foodPoint = delegate.getFoodPosition()
        let snakePoints = delegate.getSnakePath()

        if let sublayers = self.layer.sublayers, sublayers.count >= 2 {
            self.layer.sublayers!.removeSubrange(1..<sublayers.count)
        } else {
            let backgroundLayer = generateBackgroundLayer(area: area, size: size)

            self.layer.addSublayer(backgroundLayer[0])
            self.layer.addSublayer(backgroundLayer[1])
        }

        self.layer.addSublayer(generateFoodLayer(point: foodPoint, size: size))
        self.layer.addSublayer(generateSnakeLayer(points: snakePoints, size: size))
    }

    private func generateSnakeLayer(points: [Point], size: Int) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()

        for point in points {
            path.append(UIBezierPath(rect: CGRect(x: point.x, y: point.y, width: size, height: size)))
        }

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = snakeColor.cgColor

        return shapeLayer
    }

    private func generateFoodLayer(point: Point, size: Int) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: point.x, y: point.y, width: size, height: size), cornerRadius: 2).cgPath
        shapeLayer.fillColor = foodColor.cgColor

        return shapeLayer
    }

    private func generateBackgroundLayer(area: Area, size: Int) -> [CAShapeLayer] {
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
        oddShapeLayer.fillColor = oddGridColor.cgColor
        evenShapeLayer.path = oddPath.cgPath
        evenShapeLayer.fillColor = evenGridColor.cgColor

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
