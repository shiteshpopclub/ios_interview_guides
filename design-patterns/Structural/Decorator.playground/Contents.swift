import UIKit

/*
 https://blog.logrocket.com/simplifying-codebase-swift-decorator-design-pattern/#:~:text=the%20decorator%20pattern-,What%20is%20Swift's%20decorator%20pattern%3F,objects%20of%20the%20same%20class.
 
 
 https://www.youtube.com/watch?v=SWpsW-VptH8
 
 Decorative(structural)
 
 The decorator pattern, also called the wrapper pattern, is a structural design pattern in object-oriented programming that utilizes composition, providing a flexible way to dynamically extend an object’s behavior without affecting the behavior of other objects of the same class.
 
 */


protocol Pizza {
    var description: String { get }
    var cost: CGFloat { get }
}

class CheesePizza: Pizza {
    var description: String { "cheese pizza" }
    
    var cost: CGFloat { 8.99 }
}

class ToppingDecorator: Pizza {
    let basePizza: Pizza
    let topping: String
    let toppingCost: Double

    init(basePizza: Pizza, topping: String, toppingCost: Double) {
        self.basePizza = basePizza
        self.topping = topping
        self.toppingCost = toppingCost
    }

    var description: String {
        return "\(basePizza.description), with \(topping)"
    }

    var cost: CGFloat {
        return basePizza.cost + toppingCost
    }
}


let basePizza = CheesePizza()
let pepperoniPizza = ToppingDecorator(basePizza: basePizza, topping: "pepperoni", toppingCost: 1.99)
let pepperoniMushroomPizza = ToppingDecorator(basePizza: pepperoniPizza, topping: "mushrooms", toppingCost: 0.99)

print(pepperoniMushroomPizza.description) // "Cheese pizza, with pepperoni, with mushrooms"
print(pepperoniMushroomPizza.cost) // 11.97
