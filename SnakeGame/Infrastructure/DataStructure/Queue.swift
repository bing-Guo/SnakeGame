import Foundation

class Queue<T> {
    private(set) var array = [T]()

    func push(_ element: T) {
        array.append(element)
    }

    func pop() -> T {
        return array.removeFirst()
    }

    func getFront() -> T? {
        return array.first
    }

    func getBack() -> T? {
        return array.last
    }

    func getSize() -> Int {
        return array.count
    }

    func isEmpty() -> Bool {
        return array.isEmpty
    }
}
