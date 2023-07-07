import UIKit

/*
 Builder design pattern (creational)
 
 Builder design pattern is a creational design pattern that builds an object step by step without having to change the recipe, like a hamburger.
 
 Use the builder pattern when you want to create a complex object using a series of steps.

 This pattern works especially well when a product requires multiple inputs.
 */


//MARK: - Product
public struct Hamburger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

extension Hamburger: CustomStringConvertible {
    public var description: String {
        return ("Here is your burger. It has \(meat.rawValue) as meat; \(sauce.description) as sauce; and \(toppings.description) as topping in it. Bon Appetit!")
    }
}

public enum Meat: String {
    case beef
    case chicken
    case tofu
}

public struct Sauces: OptionSet {
    
    public let rawValue: Int
    
    public static let mayonnaise = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let barbeque = Sauces(rawValue: 1 << 3)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Sauces: CustomStringConvertible {
    
    static public var debugDescriptions: [(Self, String)] = [
        (.mayonnaise, "mayonnaise"),
        (.mustard, "mustard"),
        (.ketchup, "ketchup"),
        (.barbeque, "barbeque")
    ]
    
    public var description: String {
        let result: [String] = Self.debugDescriptions.filter { contains($0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")
        
        return "\(printable)"
    }
}

public struct Toppings: OptionSet {
    public let rawValue: Int
    
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let onion = Toppings(rawValue: 1 << 1)
    public static let lettuce = Toppings(rawValue: 1 << 2)
    public static let pickles = Toppings(rawValue: 1 << 3)
    public static let tomatoes = Toppings(rawValue: 1 << 4)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension Toppings: CustomStringConvertible {
    
    static public var debugDescriptions: [(Self, String)] = [
        (.cheese, "cheese"),
        (.onion, "onion"),
        (.lettuce, "lettuce"),
        (.pickles, "pickles"),
        (.tomatoes, "tomatoes")
    ]
    
    public var description: String {
        let result: [String] = Self.debugDescriptions.filter { contains($0.0) }.map { $0.1 }
        let printable = result.joined(separator: ", ")
        
        return "\(printable)"
    }
}

// MARK: - Builder
public class HamburgerBuilder {
    
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    
    public func addSauces(_ sauce: Sauces) {
        sauces.insert(sauce)
    }
    public func removeSauces(_ sauce: Sauces) {
        sauces.remove(sauce)
    }
    public func addToppings(_ topping: Toppings) {
        toppings.insert(topping)
    }
    public func removeToppings(_ topping: Toppings) {
        toppings.remove(topping)
    }
    public func setMeat(_ meat: Meat) {
        self.meat = meat
    }
    
    public func build() -> Hamburger {
        return Hamburger(meat: meat,
                         sauce: sauces,
                         toppings: toppings)
    }
}

// MARK: - Director
public class BurgerShop {
    
    public func createCheeseBurger(using builder: HamburgerBuilder) -> Hamburger {
        builder.setMeat(.beef)
        builder.addToppings([.cheese, .lettuce, .tomatoes])
        builder.addSauces([.barbeque, .ketchup, .mayonnaise])
        return builder.build()
    }
    
    public func createVegetarianBurger(using builder: HamburgerBuilder) -> Hamburger {
        builder.setMeat(.tofu)
        builder.addSauces([.mayonnaise, .mustard])
        builder.addToppings([.lettuce, .tomatoes, .pickles])
        return builder.build()
    }
}

//MARK: - Predefined Builder Example
//let biberBurger = BiberBurger()
//
//// BiberBurger() class has prebuild formulas, and uses a HamburgerBuilder() instance. With the same instance formula is saved everytime it's used.
//let hamburgerBuilder = HamburgerBuilder()
//
//let cheeseBurger = biberBurger.createCheeseBurger(using: hamburgerBuilder)
//
//print(cheeseBurger.description)
//
//// If BiberBuger wants to build on a new default burger, they can use new instance.
//let vegetarianBurger = biberBurger.createVegetarianBurger(using: HamburgerBuilder())
//
//print(vegetarianBurger.description)


//MARK: - Custom hamburger builder
// Let's create another hamburger builder, so I can create my own burger!
let myCustomBurgerBuilder = HamburgerBuilder()

myCustomBurgerBuilder.setMeat(.chicken)
myCustomBurgerBuilder.addSauces([.mayonnaise, .ketchup, .barbeque, .mustard])
myCustomBurgerBuilder.addToppings([.cheese, .lettuce, .onion, .pickles])

// I don't want mustard
myCustomBurgerBuilder.removeSauces(.mustard)

// I don't want onion
myCustomBurgerBuilder.removeToppings(.onion)

// I forgot tomatoes
myCustomBurgerBuilder.addToppings(.tomatoes)

let myCustomBurger = myCustomBurgerBuilder.build()

print(myCustomBurger.description)
