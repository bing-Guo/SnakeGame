import Foundation

class Snake {
    private(set) var queue: Queue<Point> = Queue<Point>()
    
    let unit: Int

    var path: [Point] {
        return queue.array
    }
    var head: Point {
        return queue.getBack()!
    }
    var body: [Point] {
        let lengthWithoutHead = queue.getSize() - 1

        return Array(queue.array[0..<lengthWithoutHead])
    }

    private(set) var direction: Direction = .right

    // MARK: - Initializer
    init(start: Point, direction: Direction, length: Int, unit: Int) {
        self.unit = unit
        self.direction = direction

        queue.push(start)

        for _ in 1..<length {
            lengthenBody()
        }
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
            queue.push(Point(x: head.x, y: head.y - unit))
        case .left:
            queue.push(Point(x: head.x - unit, y: head.y))
        case .right:
            queue.push(Point(x: head.x + unit, y: head.y))
        case .down:
            queue.push(Point(x: head.x, y: head.y + unit))
        }
    }

    func isBodyOverlap() -> Bool {
        return body.contains { isHeadOverlap(with: $0) }
    }

    func isHeadOverlap(with point: Point) -> Bool {
        return head == point
    }

    func isHeadOutOfArea(_ area: Area) -> Bool {
        return head.x < area.leftTop.x
            || head.x >= area.rightBottom.x
            || head.y < area.leftTop.y
            || head.y >= area.rightBottom.y
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
