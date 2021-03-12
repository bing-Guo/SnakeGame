import Foundation

class GameViewModel {
    let gridUnit: Int = 20
    let timeInterval: Double = 0.5

    var snake: Snake
    var food: Food
    var boundary: Area
    var updateView: (() -> Void)?
    var startGame: (() -> Void)?
    var showGameOverView: (() -> Void)?
    
    init() {
        snake = Snake(start: Point(x: gridUnit, y: gridUnit), direction: .right, length: 1, unit: gridUnit)
        food = Food(position: Point(x: 100, y: 100))
        boundary = Area(leftTop: Point(x: 0, y: 0), rightTop: Point(x: 0, y: 0), leftBottom: Point(x: 0, y: 0), rightBottom: Point(x: 0, y: 0))
    }

    func start() {
        snake = Snake(start: Point(x: gridUnit, y: gridUnit), direction: .right, length: 1, unit: gridUnit)
        food = generateRandomFood()

        startGame?()
    }

    func finish() {
        showGameOverView?()
    }

    func checkGameState() {
        if snake.isHeadOverlap(with: food.position) {
            snake.lengthenBody()
            resetFood()
        } else {
            snake.moveForward()
        }

        if isFailedState() {
            finish()
        } else {
            updateView?()
        }
    }

    func turnDirection(_ direction: Direction) {
        snake.turnDirection(direction)
    }

    private func isFailedState() -> Bool {
        return snake.isBodyOverlap() || snake.isHeadOutOfArea(boundary)
    }

    private func resetFood() {
        food = generateRandomFood()
    }

    private func generateRandomFood() -> Food {
        let maxX = Int(boundary.rightBottom.x / gridUnit)
        let maxY = Int(boundary.rightBottom.y / gridUnit)
        let x = Int.random(in: 0..<maxX) * gridUnit
        let y = Int.random(in: 0..<maxY) * gridUnit

        return Food(position: Point(x: x, y: y))
    }
}
