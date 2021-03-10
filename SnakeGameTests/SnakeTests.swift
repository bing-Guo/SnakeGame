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
        let snake = Snake(start: Point(x: 0, y: 0), direction: .right, length: 5, stepDistance: 10)

        XCTAssertEqual(snake.queue.getSize(), 5)
    }

    func testSnake_InitialDirection_True() throws {
        let snake = Snake(start: Point(x: 0, y: 0), direction: .down, length: 5, stepDistance: 10)

        XCTAssertEqual(snake.direction, .down)
    }

    func testSnake_InitialPosition_True() throws {
        let snake = Snake(start: Point(x: 0, y: 0), direction: .right, length: 3, stepDistance: 10)
        let path = [
            Point(x: 0, y: 0),
            Point(x: 10, y: 0),
            Point(x: 20, y: 0)
        ]

        XCTAssertEqual(snake.queue.array, path)
    }

    // MARK: - Move
    func testSnake_MoveRightOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, stepDistance: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 40, y: 10)
        ]

        snake.moveForward()

        XCTAssertEqual(snake.queue.array, path)
    }

    func testSnake_MoveDownOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, stepDistance: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 30, y: 20)
        ]

        snake.turnDirection(.down)
        snake.moveForward()

        XCTAssertEqual(snake.queue.array, path)
    }

    func testSnake_MoveUpOneStep_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, stepDistance: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 30, y: 0)
        ]

        snake.turnDirection(.up)
        snake.moveForward()

        XCTAssertEqual(snake.queue.array, path)
    }

    func testSnake_MoveLeftAndInvalidDirection_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, stepDistance: 10)
        let path = [
            Point(x: 20, y: 10),
            Point(x: 30, y: 10),
            Point(x: 40, y: 10)
        ]

        snake.turnDirection(.left)
        snake.moveForward()

        XCTAssertEqual(snake.queue.array, path)
    }

    // MARK: - Collision
    func testSnake_DetectBodyCollision_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 5, stepDistance: 10)

        snake.turnDirection(.down)
        snake.moveForward()
        snake.turnDirection(.left)
        snake.moveForward()
        snake.turnDirection(.up)
        snake.moveForward()

        XCTAssertTrue(snake.isBodyOverlap(), "snake's head \(snake.head) is not hit \(snake.body)")
    }

    func testSnake_DetectBodyCollision_False() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 5, stepDistance: 10)

        snake.turnDirection(.down)
        snake.moveForward()
        snake.turnDirection(.left)
        snake.moveForward()

        XCTAssertFalse(snake.isBodyOverlap(), "snake's head \(snake.head) is hit \(snake.body)")
    }

    func testSnake_DetectHeadOverlap_True() throws {
        let snake = Snake(start: Point(x: 10, y: 10), direction: .right, length: 3, stepDistance: 10)
        let point = Point(x: 50, y: 10)

        snake.moveForward()
        snake.moveForward()

        XCTAssertTrue(snake.isHeadOverlap(with: point), "snake's head point: \(snake.head) is not hit \(point)")
    }
}
