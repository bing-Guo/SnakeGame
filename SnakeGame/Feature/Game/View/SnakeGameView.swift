import Foundation
import UIKit

protocol SnakeGameProtocol: NSObject {
    func getArea() -> Area
    func getUnit() -> Int
    func getSnakePath() -> [Point]
    func getFoodPosition() -> Point?
}

protocol SnakeGameViewLayer {
    func generateLayer() -> [CAShapeLayer]
}

class SnakeGameView: UIView {
    private var clearIndex = 0

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

        guard let delegate = delegate else {
            assertionFailure("Delegate must be set before use this class.")
            return
        }

        let size = delegate.getUnit()
        let area = delegate.getArea()
        let foodPoint = delegate.getFoodPosition()
        let snakePoints = delegate.getSnakePath()

        if self.layer.sublayers == nil {
            let layers = BackgroundLayer(size: size, area: area, oddColor: oddGridColor, evenColor: evenGridColor).generateLayer()

            for (index, layer) in layers.enumerated() {
                self.layer.addSublayer(layer)
                clearIndex = index
            }
        }

        clearLayers()

        for layer in FoodLayer(size: size, point: foodPoint, color: foodColor).generateLayer() {
            self.layer.addSublayer(layer)
        }

        for layer in SnakeLayer(size: size, points: snakePoints, color: snakeColor).generateLayer() {
            self.layer.addSublayer(layer)
        }
    }

    private func clearLayers() {
        if let sublayers = self.layer.sublayers {
            self.layer.sublayers!.removeSubrange(clearIndex..<sublayers.count)
        }
    }
}
