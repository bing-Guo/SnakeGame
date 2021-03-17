import Foundation

class GameViewModel {
    private var growthCount = 0

    let timeInterval: Double = 0.1
    let gridUnit = 20
    let growthRate = 3

    var snake: Snake
    var food: Food?
    var area: Area
    var updateView: (() -> Void)?
    var startGame: (() -> Void)?
    var showGameOverView: (() -> Void)?

    init() {
        snake = Snake(start: Point(x: gridUnit, y: gridUnit), direction: .right, length: 1, unit: gridUnit)
        area = Area(leftTop: Point(x: 0, y: 0), rightTop: Point(x: 0, y: 0), leftBottom: Point(x: 0, y: 0), rightBottom: Point(x: 0, y: 0))
    }

    func start() {
        snake = Snake(start: Point(x: gridUnit, y: gridUnit), direction: .right, length: 3, unit: gridUnit)
        food = generateRandomFood()

        startGame?()
    }

    func finish() {
        showGameOverView?()
    }

    func checkGameState() {
        if let food = food, snake.isOverlap(with: food.position) {
            snake.lengthenBody()
            resetFood()
            growthCount += (growthRate - 1)
        } else if growthCount > 0 {
            snake.lengthenBody()
            growthCount -= 1
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
        print(direction, snake.path)
        snake.turnDirection(direction)
    }

    // MARK: - Private Method
    private func isFailedState() -> Bool {
        return snake.isBodyOverlap() || snake.isHeadOutOfArea(area)
    }

    private func resetFood() {
        food = generateRandomFood()
    }

    private func generateRandomFood() -> Food {
        let maxX = Int(area.rightBottom.x / gridUnit)
        let maxY = Int(area.rightBottom.y / gridUnit)
        let x = Int.random(in: 0..<maxX) * gridUnit
        let y = Int.random(in: 0..<maxY) * gridUnit

        return Food(position: Point(x: x, y: y))
    }
}
