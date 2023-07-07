import UIKit

/*
 https://medium.com/swiftworld/swift-world-design-patterns-facade-579ef4b3319f
 
 Facade
 
 Literally, facade means

 the face of a building, especially the principal front that looks onto a street or open space.

 from Facade — Google Search

 Similarly, as design pattern facade defines an simpler interface to an complex subsystem. For example, in our car factory, we have different departments to produce different components like engine, body, and accessories. As client, we don’t care how every department does produce its own job. We just create a factory instance and get it to work.
 */


class Engine {
    func produceEngine() {
        print("prodce engine")
    }
}

class Body {
    func produceBody() {
        print("prodce body")
    }
}

class Accessories {
    func produceAccessories() {
        print("prodce accessories")
    }
}


class FactoryFacade {
    private let engine: Engine = Engine()
    private let body: Body = Body()
    private let accessories: Accessories = Accessories()
    
    func produceCar() {
        engine.produceEngine()
        body.produceBody()
        accessories.produceAccessories()
        print("car produced")
    }
}


let factoryFacade = FactoryFacade()
factoryFacade.produceCar()
