import Foundation
import UIKit

protocol SnakeGameProtocol: NSObject {
    func getUnit() -> Int
    func getSnakePath() -> [Point]
    func getFoodPosition() -> Point
}

class SnakeGameView: UIView {
    weak var delegate: SnakeGameProtocol?

    var snakeColor: UIColor = .black
    var snakeBorderColor: UIColor = UIColor(rgb: 0xACB807)
    var foodColor: UIColor = UIColor(rgb: 0xB8211A)
    var foodBorderColor: UIColor = UIColor(rgb: 0xACB807)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        clearLayer()

        if let layer = generateFoodLayer() {
            self.layer.addSublayer(layer)
        }

        if let layer = generateSnakeLayer() {
            self.layer.addSublayer(layer)
        }
    }

    private func clearLayer() {
        self.layer.sublayers = nil
    }

    private func generateSnakeLayer() -> CAShapeLayer? {
        guard let delegate = delegate else { return nil }

        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        let size = delegate.getUnit()

        for point in delegate.getSnakePath() {
            path.append(UIBezierPath(rect: CGRect(x: point.x, y: point.y, width: size, height: size)))
        }

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = snakeBorderColor.cgColor
        shapeLayer.fillColor = snakeColor.cgColor

        return shapeLayer
    }

    private func generateFoodLayer() -> CAShapeLayer? {
        guard let delegate = delegate else { return nil }

        let shapeLayer = CAShapeLayer()
        let point = delegate.getFoodPosition()
        let size = delegate.getUnit()

        shapeLayer.path = UIBezierPath(rect: CGRect(x: point.x, y: point.y, width: size, height: size)).cgPath
        shapeLayer.strokeColor = foodBorderColor.cgColor
        shapeLayer.fillColor = foodColor.cgColor

        return shapeLayer
    }

    private func generateBorderLayer() -> CAShapeLayer? {
        return nil
    }
}
