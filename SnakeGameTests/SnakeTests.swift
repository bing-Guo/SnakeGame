import XCTest
@testable import SnakeGame

class SnakeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Initial
    func testSnake_InitialLength_True() throws {
        let snake = Snake(start: Point(x: 0, y: 0), direction: .right, length: 5, unit: 10)

        XCTAssertEqual(snake.queue.getSize(), 5)
    }

    func testSnake_InitialDirection_True() throws {
        let snake = Snake(start: Point(x: 0, y: 0), direction: .down, length: 5, unit: 10)

        XCTAssertEqual(snake.direction, .down)
    }

    func testSnake_InitialPosition_True() throws {
        let snake = Snake(start: Point(x: 0, y: 0), direction: .right, length: 3, unit: 10)
        let path = [
            Point(x: 0, y: 0),
            Point(x: 10, y: 0),
            Point(x: 20, y: 0)
        ]

        XCTAssertEqual(snake.path, path)
    }

    // MARK: - Move
    func testSnake_MoveRightOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, unit: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 40, y: 10)
        ]

        snake.moveForward()

        XCTAssertEqual(snake.path, path)
    }

    func testSnake_MoveDownOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, unit: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 30, y: 20)
        ]

        snake.turnDirection(.down)
        snake.moveForward()

        XCTAssertEqual(snake.path, path)
    }

    func testSnake_MoveUpOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, unit: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 30, y: 0)
        ]

        snake.turnDirection(.up)
        snake.moveForward()

        XCTAssertEqual(snake.path, path)
    }

    func testSnake_MoveLeftAndInvalidDirection_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, unit: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 40, y: 10)
        ]

        snake.turnDirection(.left)
        snake.moveForward()

        XCTAssertEqual(snake.path, path)
    }

    // MARK: - Collision
    func testSnake_DetectBodyCollision_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 5, unit: 10)

        snake.turnDirection(.down)
        snake.moveForward()
        snake.turnDirection(.left)
        snake.moveForward()
        snake.turnDirection(.up)
        snake.moveForward()

        XCTAssertTrue(snake.isBodyOverlap(), "snake's head \(snake.head) is not hit \(snake.body)")
    }

    func testSnake_DetectBodyCollision_False() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 5, unit: 10)

        snake.turnDirection(.down)
        snake.moveForward()
        snake.turnDirection(.left)
        snake.moveForward()

        XCTAssertFalse(snake.isBodyOverlap(), "snake's head \(snake.head) is hit \(snake.body)")
    }

    func testSnake_DetectHeadOverlap_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, unit: 10)
        let point = Point(x: 50, y: 10)

        snake.moveForward()
        snake.moveForward()

        XCTAssertTrue(snake.isHeadOverlap(with: point), "snake's head point: \(snake.head) is not hit \(point)")
    }

    func testSnake_DetectHeadOutOfArea_True() throws {
        let snake = Snake(start: Point(x: 90, y: 90), direction: .right, length: 5, unit: 10)
        let area = Area(leftTop: Point(x: 0, y: 0), rightTop: Point(x: 100, y: 0), leftBottom: Point(x: 0, y: 100), rightBottom: Point(x: 100, y: 100))

        XCTAssertTrue(snake.isHeadOutOfArea(area), "snake's head point: \(snake.head) is not in \(area)")
    }

    func testSnake_DetectHeadOutOfArea_False() throws {
        let snake = Snake(start: Point(x: 50, y: 90), direction: .right, length: 5, unit: 10)
        let area = Area(leftTop: Point(x: 0, y: 0), rightTop: Point(x: 100, y: 0), leftBottom: Point(x: 0, y: 100), rightBottom: Point(x: 100, y: 100))

        XCTAssertFalse(snake.isHeadOutOfArea(area), "snake's head point: \(snake.head) is out of area \(area)")
    }
}
