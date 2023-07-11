import UIKit

/*
 Map
 */

extension Array {
    func myMap<T>(transform: (Element) -> T) -> [T] {
        var result: [T] = []
        
        forEach { element in
            result.append(transform(element))
        }
        
        return result
    }
}

let a = [1, 2, 3, 4, 5]
print(a.myMap{$0/2})


/*
 Compact map
 */

extension Array {
    func myCompactMap<T>(transform: (Element) -> T?) -> [T] {
        var result: [T] = []
        
        forEach { element in
            if let transformValue = transform(element) {
                result.append(transformValue)
            }
        }
        
        return result
    }
}

let a1 = ["1", "2", "3", "ddsfdf"]
print(a1.myCompactMap{ Int($0) })
print(a1.myMap{ Int($0) })

/*
 Filter
 */


extension Array {
    func myFilter(filter: (Element) -> Bool) -> [Element]? {
        var result:[Element]? = []
        
        forEach { element in
            if filter(element) {
                result?.append(element)
            }
        }
        
        return result
    }
}

print(a.myFilter{ $0 % 2 == 0 })

/*
 Reduce
 */


extension Array {
    func myReduce<T>(_ initialValue: T, _ partialResult: (T, Element) -> T) -> T {
        var result = initialValue
        
        forEach { element in
            result = partialResult(result, element)
        }
        
        return result
    }
}

let numberSum = a.myReduce(10) { result, element in
    result + element
}

print("numberSum: \(numberSum)")


let a15 = 10
let b = 15
let c = 8

if a15 <= b && c <= b {
    print("2232323333")
}
