import UIKit

/*
 https://betterprogramming.pub/swift-s-o-l-i-d-21203ba3a226
 
 S: Single Responsibility Principle (SRP)
 O: Open/Closed Principle (OCP)
 L: Liskov Substitution Principle (LSP)
 I: Interface Segregation Principle (ISP)
 D:
 */


/*
 (O) Open/Closed Principle
 
 In simple terms, Entities should be open for extension but closed for modification.
 
 */

/*
 
 class PaymentManager {
     func makeCashPayment(amount: Double) {
         //perform
     }

     func makeVisaPayment(amount: Double) {
         //perform
     }
 }
 
 here if you need to add more payment methods then you will add a new method in class PaymentManager which will break Open/Close principle
 */


// design to solve open/close principle


protocol PaymentProtocol {
    func makePayment(amount: Double)
}


class CashPayment: PaymentProtocol {
    func makePayment(amount: Double) {
        print("Payment done through cash: \(amount)")
    }
}

class CardPayment: PaymentProtocol {
    func makePayment(amount: Double) {
        print("Payment done through card: \(amount)")
    }
}

class UPIPayment: PaymentProtocol {
    func makePayment(amount: Double) {
        print("Payment done through UPI: \(amount)")
    }
}


class PaymentManager {
    func makePayment(amount: Double, method: PaymentProtocol) {
        method.makePayment(amount: amount)
    }
}


let cardPayment: CardPayment = CardPayment()
let upiPayment: UPIPayment = UPIPayment()

let paymentManager = PaymentManager()
paymentManager.makePayment(amount: 200, method: cardPayment)
paymentManager.makePayment(amount: 400, method: upiPayment)


/*
 (L) Liskov Substitution Principle
 
 Objects should be replaced with instances of their subclasses without altering the behavior.

 
 class Rectangle {
     var width: Double
     var height: Double
     
     init(width: Double, height: Double) {
         self.width = width
         self.height = height
     }

     func calculateArea() -> Double {
         return width * height
     }
 }


 // breaking Liskov Substitution Principle
 class Square: Rectangle {
     init(width: Double) {
         super.init(width: width, height: width)
     }
 }

 let rectangle = Rectangle(width: 4, height: 5)
 print("rectangle area: \(rectangle.calculateArea())")

 let square = Square(width: 4)
 print("square area: \(square.calculateArea())")
 */


protocol Polygon {
    func calculateArea() -> Double
}

class Rectangle: Polygon {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func calculateArea() -> Double {
        return width * height
    }
}

class Square: Polygon {
    var width: Double

    init(width: Double) {
        self.width = width
    }

    func calculateArea() -> Double {
        return width * width
    }
}

let rectangle = Rectangle(width: 4, height: 5)
print("rectangle area: \(rectangle.calculateArea())")

let square = Square(width: 4)
print("square area: \(square.calculateArea())")


/*
 (I) Interface Segregation Principle
 
 
 It states that clients should not be forced to implement interfaces they don’t use. Instead of one fat interface, many small interfaces are preferred based on groups of methods, each one serving one submodule.

 protocol Worker {
     func eat()
     func work()
 }

 class Human: Worker {
     func eat() {
         print("eating")
     }

     func work() {
         print("working")
     }
 }


 class Robot: Worker {
     func eat() {
         // Robots can't eat but we have to implement eat() it breaks ISP
         fatalError("Robots does not eat!")
     }

     func work() {
         print("working")
     }
 }
 */

protocol Feedable {
    func eat()
}

protocol Workable {
    func work()
}

class Human: Feedable, Workable {
    func eat() {
        
    }
    
    func work() {
        
    }
}


class Robot: Workable {
    func work() {
        
    }
}

/*
 (D) Dependency Inversion Principle
 
 
 DIP theoretically high-level modules should not import anything from low-level modules. Both should depend on abstractions and Abstractions should not depend on details. Details should depend on abstractions.
 
 
 High-level modules should not depend on low-level modules both should depend on Abstractions. (Abstractions should not depend upon details. Details should depend upon abstractions)
 
 
 struct Employee {
     func work() {
         print("working...")
     }
 }

 struct Employer {
     var employees: [Employee]

     func manage() {
         employees.forEach { employee in
             employee.work()
         }
     }
 }

 func run() {
     let employer = Employer(employees: [Employee()])
     employer.manage()
 }
 
 */

struct Employee: Workable {
    var name: String

    func work() {
        print("Employee \(name) is working")
    }
}

struct Employer {
    var employees: [Workable]
    
    func manage() {
        for employee in employees {
            employee.work()
        }
    }
}

func run() {
    let employer = Employer(employees: [
        Employee(name: "Shitesh"),
        Employee(name: "Saurabh")
    ])
    employer.manage()
}

run()


var name = "Shitesh"
let sayGoodMorning = { [name] in
    print("Good morning \(name)")
}

name = "Ritesh"
sayGoodMorning()
