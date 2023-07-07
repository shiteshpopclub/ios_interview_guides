import UIKit

/*
 https://medium.com/swiftcraft/swift-solutions-adapter-pattern-a2118a6a2910

 The Adapter pattern is pretty common in Swift code. It’s very often used in systems based on some legacy code. In such cases, Adapters make legacy code work with modern classes.
 
 Adapter is recognizable by a constructor which takes an instance of a different abstract/interface type. When adapter receives a call to any of its methods, it translates parameters to appropriate format and then directs the call to one or several methods of the wrapped object.
 */


protocol Jumping {
  func jump()
}

class Dog: Jumping {
  func jump() {
    print("Jumps Excitedly")
  }
}

class Cat: Jumping {
  func jump() {
    print("Pounces")
  }
}
 
let dog = Dog()
let cat = Cat()

class Frog {
  func leap() {
    print("Leaps")
  }
}

let frog = Frog()

extension Frog: Jumping {
    func jump() {
        leap()
    }
}


var animals: [Jumping] = [dog, cat, frog]

func jumpAll(animals: [Jumping]) {
  for animal in animals {
    animal.jump()
  }
}

jumpAll(animals: animals)
