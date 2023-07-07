import UIKit

// https://aglowiditsolutions.com/blog/top-swift-design-patterns/

/*
 1.factory design pattern (creational)
 
 Factory Method pattern makes the codebase more flexible to add or remove new types. To add a new type, we just need a new class for the type and a new factory to produce it like the following code. We don’t need to change original codebase.
 
 The factory method pattern deals with the problem of creating objects without having to specify the exact class of the object that will be created.
 The factory pattern is useful when you need to create objects at runtime


 https://medium.com/swiftworld/swift-world-design-patterns-factory-method-2be4bb3c73cc
 https://www.youtube.com/watch?v=faeoSJhN-Ko
 */

// Model
struct Report {

    let id : UUID
    let year: Int
    let total: Double

    static func generateDummyReport() -> [Report] {
        return [Report(id: UUID(), year: Int.random(in: 2015..<2023), total: Double.random(in: 2000..<5000)),
                Report(id: UUID(), year: Int.random(in: 2015..<2023), total: Double.random(in: 2000..<5000))]
    }
}

enum ReportType {
    case tax
    case profit
    case finance
}

protocol ReportProtocol {
    func getReport() -> [Report]
}

class TaxReport: ReportProtocol {
    func getReport() -> [Report] {
        print("generated tax report")
        return Report.generateDummyReport()
    }
}

class ProfitReport: ReportProtocol {
    func getReport() -> [Report] {
        print("generated profit report")
        return Report.generateDummyReport()
    }
}

class FinanceReport: ReportProtocol {
    func getReport() -> [Report] {
        print("generated finance report")
        return Report.generateDummyReport()
    }
}

class ReportFactory {
    static func createReport(_ type: ReportType) -> ReportProtocol {
        switch type {
        case .tax:
            return TaxReport()

        case .profit:
            return ProfitReport()

        case .finance:
            return FinanceReport()
        }
    }
}


class ReportViewModel {
    private let report: ReportProtocol

    init(_ report: ReportProtocol) {
        self.report = report
    }

    func getReport() -> [Report] {
        return report.getReport()
    }
}

let taxReport: ReportProtocol = ReportFactory.createReport(.tax)
let profitReport: ReportProtocol = ReportFactory.createReport(.profit)
let financeReport: ReportProtocol = ReportFactory.createReport(.finance)

let reportVM = ReportViewModel(financeReport)
reportVM.getReport()

/*
 2.Abstract factory design pattern (creational)
 
 Abstract factory is fac tory of factory
 */

protocol AbstractFactory {
    func createProduct1() -> AbstractProduct1
    func createProduct2() -> AbstractProduct2
}

class ConcreteFactory1: AbstractFactory {
    func createProduct1() -> AbstractProduct1 {
        return Product1_1()
    }
    
    func createProduct2() -> AbstractProduct2 {
        return Product2_1()
    }
}

class ConcreteFactory2: AbstractFactory {
    func createProduct1() -> AbstractProduct1 {
        return Product1_2()
    }
    
    func createProduct2() -> AbstractProduct2 {
        return Product2_2()
    }
}


protocol AbstractProduct1 {
    func createProduct1()
}


class Product1_1: AbstractProduct1 {
    func createProduct1() {
        print("Created product1_1")
    }
}

class Product1_2: AbstractProduct1 {
    func createProduct1() {
        print("Created product1_2")
    }
}

protocol AbstractProduct2 {
    func createProduct2()
}

class Product2_1: AbstractProduct2 {
    func createProduct2() {
        print("Created product2_1")
    }
}

class Product2_2: AbstractProduct2 {
    func createProduct2() {
        print("Created product2_2")
    }
}


let factory1: AbstractFactory = ConcreteFactory1()
let factory2: AbstractFactory = ConcreteFactory2()
var prod1: AbstractProduct1
var prod2: AbstractProduct2

//series 1 products
prod1 = factory1.createProduct1()
prod1.createProduct1()

prod2 = factory1.createProduct2()
prod2.createProduct2()


//series 2 products
prod1 = factory2.createProduct1()
prod1.createProduct1()

prod2 = factory2.createProduct2()
prod2.createProduct2()
