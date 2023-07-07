import UIKit
import Foundation

final class Ref<T> {
  var val: T
  init(_ v: T) { val = v }
}

struct Box<T> {
  var ref: Ref<T>
  init(_ x: T) { ref = Ref(x) }

  var value: T {
    get { return ref.val }
    set {
      if !isKnownUniquelyReferenced(&ref) {
        ref = Ref(newValue)
        return
      }
      ref.val = newValue
    }
  }
}

func address(of obj: UnsafeRawPointer) {
    let addr = Int(bitPattern: obj)
    print(NSString(format: "%p", addr))
}

struct Student {
    var name: String
}

var student1 = Box(Student(name: "Shitesh"))
var student2 = student1
student2.ref.val.name = "Ritesh"

address(of: &student1.ref.val)
address(of: &student2.ref.val)

print("\(student1.ref.val.name) ::: \(student2.ref.val.name)")

let array1 = [1, 2, 3]
var array2 = array1

array1.withUnsafeBufferPointer { (pointer) in
    print("array1: \(pointer)")
}

array2.withUnsafeBufferPointer { (pointer) in
    print("array2: \(pointer)")
}

array2.append(4)
array2.withUnsafeBufferPointer { (pointer) in
    print("updated array2: \(pointer)")
}


func append_one(_ a: [Int]) -> [Int] {
  var a = a
  a.append(1)
  return a
}

var a = [1, 2, 3]
a.withUnsafeBufferPointer { (pointer) in
    print("array a before append: \(pointer)")
}
a = append_one(a)
a.withUnsafeBufferPointer { (pointer) in
    print("array a after append: \(pointer)")
}


func append_one_in_place(_ a: inout [Int]) {
  a.append(1)
}

var b = [1, 2, 3]
b.withUnsafeBufferPointer { (pointer) in
    print("array b before append: \(pointer)")
}
append_one_in_place(&b)
b.withUnsafeBufferPointer { (pointer) in
    print("array b after append: \(pointer)")
}




public class Subscription {
    deinit {
        print("Deinit Subscription")
    }

    public var type: String
    public weak var user: User?
    
    public init(type: String, user: User? = nil) {
        self.type = type
        self.user = user
    }
}

public class User {
    deinit {
        print("Deinit User")
    }
    public var name: String
    public var subscriptions: Array<Subscription>
    
    public init(name: String) {
        self.name = name
        self.subscriptions = []
    }
}


var usr: User? = User(name: "John Doe")
var sub: Subscription? = Subscription(type: "Cellphone", user: usr)

if let sub = sub {
    usr?.subscriptions.append(sub)
}

print(usr)


usr = nil
sub = nil



import Foundation
let data: [Any?] = ["Bill", nil, 69, "Ted"]

for datum in data where datum is String? {
    print(datum)
}

for case let .some(datum) in data where datum is String {
    print(datum)
}


//enum Weather: CaseIterable {
//    case sunny
//    case windy(speed: Int)
//    case rainy
//}
//
//print(Weather.allCases.count)




struct Spaceship {
    fileprivate(set) var name = "Serenity"
}

var serenity = Spaceship()
serenity.name = "Jayne's Chariot"
print(serenity.name)


let result = Result { try String(contentsOfFile: "") }
print(result)


let (captain, engineer, doctor) = ("Mal", "Kailee", "Simon")
print(engineer)


let result1 = UInt8.max.addingReportingOverflow(1)
print(result1)


let numbers = [1, 3, 5, 7, 9]
let result2 = numbers.reduce(0, +)
print(result2)

let names: [String?] = ["Barbara", nil, "Janet", nil, "Peter", nil, "George"]
let result3 = names.compactMap { $0 }
print(result3)

let names1 = ["Pilot": "Wash", "Doctor": "Simon"]

for (key, value) in names1.enumerated() {
    print("key: \(key)   value: \(value)")
}

for (key, value) in names1 {
    print("key: \(key)   value: \(value)")
}

/*
func greet(_ name: String = "Anonymous") {
    print("Hello, \(name)!")
}

let greetCopy = greet
greetCopy("Dave")

struct User1 {
    let name: String
}

let users = [User1(name: "Eric"), User1(name: "Maeve"), User1(name: "Otis")]
let mapped = users.map(\.name)
print(mapped)


let i = 102

if case 100...102 = i {
    print("Hello, world!")
} else {
    print("Goodbye, world!")
}

struct TaylorFan {
    fileprivate var name: String
}

var fan = TaylorFan(name: "Kailee")
fan.name = "Simon"
print(fan.name)


//func foo(_ number: Int) -> Int {
//    func bar(_ number: Int) -> Int {
//        return number * 5
//    }
//
//    return number * bar(3)
//}
//
//print(foo(2))


func foo(_ function: (Int) -> Int) -> Int {
    return function(function(5))
}

func bar<T: BinaryInteger>(_ number: T) -> T {
    return number * 3
}

print(foo(bar))
//
//// CaseIterable can only synthesize an allCases property when there are no cases with associated values.
//enum Weather: CaseIterable {
//    case sunny
//    case windy(speed: Int)
//    case rainy
//}
//
//print(Weather.allCases.count)
*/


var x: Int? = nil
x? = 10

var y: Int? = 10
y? = 5

var z: Int? = nil
z = 10

print("x: \(x)  y: \(y)  z: \(z)")


let x1: String?? = .some(nil)
let outputX = (x1 ?? "inner") ?? "outer"

let y1: String?? = nil
let outputY = (y1 ?? "inner") ?? "outer"

print("x1: \(x1)  outputX: \(outputX) y1: \(y1)  outputY: \(outputY)")


import Combine

let p = Publishers.Sequence< [Int], Error> (sequence: [1, 4, 8])
p.append([3, 8, 10]).filter { $0 >= 3 }.count()
let allEven = p.tryAllSatisfy { $0 % 2 == 0 }

print("allEven.result:: \(allEven.result)")


var dict: [String: Int?] = [
"one": 1,
"two": 2,
"none": nil
]
var otherDict: [String: Int?] = [
"one": 1,
"two": 2,
"none": nil
]
let Dicts = dict
dict ["two"] = nil
dict ["none"] = nil
print(dict.count, Dicts.count, otherDict.count)


func check(a: () -> ( )) {
    func a() {
        print ("Turing")
    }
    
    a()
}

func addition(y a: () -> ()) {
    func y () {
        print ("Quiz")
    }
    
    y()
}

check {
    print ("Swift")
}

addition {
    print ("Turing")
}


func getNumber() -> Int {
    print("Fetching number...")
    return 5
}

func printStatement(_ result: @autoclosure () -> Bool) {
    // print("Here is the number: \(result())")
    print("Nothing to see here.")
}

printStatement(getNumber() == 5)

func greet(_ name: String = "Anonymous") {
    print("Hello, \(name)!")
}

let greetCopy = greet
greetCopy("Dave")

var names11 = [String]()
names11.append("Amy")

let example1 = names11.popLast()
let example2 = names11.popLast()
print(example1, example2)


enum Planet: Int {
    case Mercury = 1
    case Venus
    case Earth
    case Mars
}

let test = Planet(rawValue: 5)
print(test)

let result12 = UInt8.max.addingReportingOverflow(1)
print(result12)

let data30: [Any?] = ["Bill", nil, 69, "Ted"]

for datum in data30 where datum is String? {
    print(datum)
}

print("**************")
for case let .some(datum) in data30 where datum is String {
    print(datum)
}


