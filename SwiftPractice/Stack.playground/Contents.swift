import UIKit

struct IntStack {
    var size: Int
    var array: [Int]
    
    init() {
        size = 0
        array = Array(repeating: 0, count: 8)
    }
    
    init(stack: [Int]) {
        size = stack.count
        array = stack
    }
    
    func peek() -> Int {
        return array[size-1]
    }
    
    mutating func pop() -> Int {
        if (size == 0) {
            return -1
        }
        let val = array[size-1]
        array[size] = 0
        return val
    }
    
    mutating func add(val: Int) {
        array[size] = val
        size += 1
    }
}

var test0 = IntStack()
test0.add(val:1)
print(test0.peek() == 1)
print(test0.pop() == 1)
