import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*
class CustomThread {
    
    deinit {
        print("\(#file) \(#line) \(#function)")
    }

    func creatThread() {
        let thread: Thread = Thread(target: self, selector: #selector(threadSelector), object: nil)
        thread.start()
    }

    func stopThread() {
        
    }

    @objc func threadSelector() {
        print("Custom thread in action")
    }
}

var customThread: CustomThread? = CustomThread()
customThread?.creatThread()

customThread = nil

*/

/*
 var counter = 1
 
 DispatchQueue.main.async {
 for i in 0...3 {
 counter = i
 print(counter)
 }
 }
 
 for i in 4...9 {
 counter = i
 print(counter)
 }
 
 
 DispatchQueue.main.async {
 counter = 10
 print(counter)
 }
 */

/*
DispatchQueue.global(qos: .background).async {
    for i in 0...2 {
        print(i)
    }
}

DispatchQueue.global(qos: .userInitiated).async {
    for i in 3...5 {
        print(i)
    }
}

DispatchQueue.global(qos: .userInteractive).async {
    for i in 6...8 {
        print(i)
    }
}
*/


/*
let a = DispatchQueue(label: "A")
let b = DispatchQueue(label: "B", attributes: .concurrent, target: a)

a.async {
    for i in 0...3 {
        print(i)
    }
}

a.async {
    for i in 4...8 {
        print(i)
    }
}

b.async {
    for i in 9...13 {
        print(i)
    }
}

b.async {
    for i in 14...18 {
        print(i)
    }
}
*/

/*
// Use of dispatch barrier

class Item {
    let price: Int = 30
}

class PurchaseItems {
    var balance: Int = 50

    let items = [Item(), Item(), Item()]
    let purchaseQueue = DispatchQueue(label: "purchaseQueue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 1)

    func purchase() {
        for item in items {
            purchaseQueue.async { [weak self] in
                self?.purchasteItem(item)
            }
            
//            purchaseQueue.async(flags: .barrier) { [weak self] in
//                self?.purchasteItem(item)
//            }
        }
    }

    private func purchasteItem(_ item: Item) {
        semaphore.wait()
        if self.balance >= item.price {
            sleep(2)
            self.balance -= item.price
            print("Item purchased: \(self.balance)")
            semaphore.signal()
        } else {
            print("Available balance is less than item price: \(self.balance)")
        }
        
    }
    
}

let purchaseItem = PurchaseItems()
purchaseItem.purchase()
*/

// Operation and operation queue


class OperationTest {
    func testOperation() {
        let operationQueue = OperationQueue()
//        operationQueue.maxConcurrentOperationCount = 1

        let operation1 = BlockOperation ()
        operation1.completionBlock = {
            print("Execution completed")
        }

        operation1.addExecutionBlock {
            for i in 0...5 {
                print(i)
            }
        }
        operation1.addExecutionBlock {
            print("Second block executed")
        }

        let operation2 = BlockOperation()
        operation2.addExecutionBlock {
            for i in 6...10 {
                print(i)
            }
        }
        operation2.addExecutionBlock {
            print("Fourth block executed")
        }

        operation1.addDependency(operation2)
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
    }
}

//print("Operation about to start")
//let test = OperationTest()
//test.testOperation()
//print("Operation completed")



class OperationTestTwo {
    func testOperation() {
        let operationQueue = OperationQueue()

        let operation1 = BlockOperation(block: printOneToTen)
        let operation2 = BlockOperation(block: printElevenToTwenty)

        operation2.addDependency(operation1)
        operationQueue.addOperation(operation1)
        operationQueue.addOperation(operation2)
    }

    func printOneToTen() {
        DispatchQueue.global().async {
            for i in 1...10 {
                print(i)
            }
        }
    }

    func printElevenToTwenty() {
        DispatchQueue.global().async {
            for i in 11...20 {
                print(i)
            }
        }
    }
}

let test2 = OperationTestTwo()
test2.testOperation()



struct Ticket {
    var number: Int
    var name: String
}

class TicketBookingSystem {
    
    var availableTicket = 5
    private let concurrentQueue = DispatchQueue(label: "com.gcd.DispatchBarrierDemo", attributes: .concurrent)
    private let semaphone = DispatchSemaphore(value: 1)
    
    var tickets = [Ticket(number: 3, name: "Nilesh"),
                   Ticket(number: 2, name: "Ramesh"),
                   Ticket(number: 4, name: "Mahesh"),
                   Ticket(number: 7, name: "Somesh")]

    
    func buyTickets() {
        for ticket in tickets {
//            concurrentQueue.async(flags: .barrier) {
//                self.book(ticket: ticket)
//            }
            
            concurrentQueue.async() {
                self.book(ticket: ticket)
            }
        }
    }
    
    func book(ticket: Ticket) {
        semaphone.wait()
        print("ticket booking started \(ticket.name)")
        sleep(1)
        if availableTicket >= ticket.number {
            availableTicket = availableTicket - ticket.number
            print("Ticket is successfull \(ticket.name)")
        } else {
            print("Ticket is unsuccessfull \(ticket.name)")
        }
        semaphone.signal()
    }
    
    func doSomethingElse() {
        print("Here I am always doing what I want")
    }
}


let ticketBookingSystem = TicketBookingSystem()
ticketBookingSystem.buyTickets()
ticketBookingSystem.doSomethingElse()



/*
 DISPATCH GROUP
 */


class DispatchGrpDemo {
    var result: [Int] = []
    let datafetchQueue = DispatchQueue(label: "com.DispatchGrpDemo", attributes: .concurrent)
    let dispatchGroup = DispatchGroup()

    func fetchData() {
        print("start fetching data")
        fetchData1()
        fetchData2()
        fetchData3()
        fetchData4()

        dispatchGroup.notify(queue: .main) { [weak self] in
            print("Result:: \(String(describing: self?.result))")
        }
    }

    private func fetchData1() {
        dispatchGroup.enter()
        var value = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) { [weak self] in
            self?.result.append(value)
            self?.dispatchGroup.leave()
        }

    }

    private func fetchData2() {
        dispatchGroup.enter()
        var value = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            value = 2
            self?.result.append(value)
            self?.dispatchGroup.leave()
        }

    }

    private func fetchData3() {
        dispatchGroup.enter()
        var value = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            value = 3
            self?.result.append(value)
            self?.dispatchGroup.leave()
        }
    }

    private func fetchData4() {
        dispatchGroup.enter()
        var value = 1

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            value = 4
            self?.result.append(value)
            self?.dispatchGroup.leave()
        }
    }
}

let dispatchGrpDemo = DispatchGrpDemo()
dispatchGrpDemo.fetchData()
