import Foundation

class Snake {
    let stepDistance: Int

    var queue: Queue<Point> = Queue<Point>()
    var head: Point {
        return queue.getBack()!
    }
    var body: [Point] {
        let lengthWithoutHead = queue.getSize() - 1

        return Array(queue.array[0..<lengthWithoutHead])
    }

    private(set) var direction: Direction = .right

    // MARK: - Initializer
    init(start: Point, direction: Direction, length: Int, stepDistance: Int) {
        self.stepDistance = stepDistance
        self.direction = direction

        queue.push(start)

        for _ in 1..<length {
            lengthenBody()
        }
    }

    convenience init(start: Point) {
        self.init(start: start, direction: .right, length: 3, stepDistance: 10)
    }

    // MARK: - Method
    func turnDirection(_ newDirection: Direction) {
        if isAllowTurnDirection(newDirection) {
            direction = newDirection
        }
    }

    func moveForward() {
        lengthenBody()

        _ = queue.pop()
    }

    func lengthenBody() {
        switch direction {
        case .up:
            queue.push(Point(x: head.x, y: head.y - stepDistance))
        case .left:
            queue.push(Point(x: head.x - stepDistance, y: head.y))
        case .right:
            queue.push(Point(x: head.x + stepDistance, y: head.y))
        case .down:
            queue.push(Point(x: head.x, y: head.y + stepDistance))
        }
    }

    func isBodyOverlap() -> Bool {
        return body.contains { isHeadOverlap(with: $0) }
    }

    func isHeadOverlap(with point: Point) -> Bool {
        return head == point
    }

    // MARK: - Private Method
    private func isAllowTurnDirection(_ newDirection: Direction) -> Bool {
        switch newDirection {
        case .up, .down:
            return (direction == .left || direction == .right) ? true : false
        case .left, .right:
            return (direction == .up || direction == .down) ? true : false
        }
    }
}
