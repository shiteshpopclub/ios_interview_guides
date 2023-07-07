import UIKit

class Node<T> {
    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?

    init(value: T) {
        self.value = value
        self.next = nil
        self.previous = nil
    }
}


class LinkedList<T> {
    private var head: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }

    var first: Node<T>? {
        return head
    }

    var last: Node<T>? {
        guard var node = head else {
            return nil
        }

        while let next = node.next {
            node = next
        }

        return node
    }

    func append(_ value: T) {
        let newNode = Node(value: value)

        guard let lastNode = last else {
            head = newNode
            return
        }

        newNode.previous = lastNode
        lastNode.next = newNode
    }

    var count: Int {
        guard var node = head else {
            return 0
        }

        var nodeCount = 1

        while let next = node.next {
            nodeCount += 1
            node = next
        }

        return nodeCount
    }

    var printElements: String {
        var elements: String = "["
        
        var node = head
        while let nodeV = node {
            elements += "\(nodeV.value)"
            
            node = node?.next
            
            if node != nil {
                elements += ", "
            }
        }

        return elements + "]"
    }

    //fetch a node at a given index
    func node(at index: Int) -> Node<T>? {
        guard var node = first, index < count else {
            return nil
        }

        for _ in 0..<index {
            if let next = node.next {
                node = next
            } else {
                break
            }
        }

        return node
    }

    func removeNode(at index: Int) -> Node<T>? {
        guard index >= 0 else {
            return nil
        }

        var removedNode: Node<T>?

        if index == 0 {
            removedNode = head
            head = head?.next
            head?.previous = nil
        } else {
            var prevNode = node(at: index - 1)
            removedNode = prevNode?.next
            let nextNode = removedNode?.next
            
            prevNode?.next = nextNode
            nextNode?.previous = prevNode
        }
        
        return removedNode
    }

    func insertNode(at index: Int, value: T) {
        guard index >= 0, index <= count else {
            return
        }

        let newNode = Node(value: value)

        if index == 0 {
            head?.previous = newNode
            newNode.next = head
            head = newNode
        } else {
            let preNode = node(at: index - 1)
            
            newNode.previous = preNode
            newNode.next = preNode?.next
            
            preNode?.next?.previous = newNode
            preNode?.next = newNode
        }
    }
}

let linkedList = LinkedList<Int>()
linkedList.append(1)
linkedList.append(2)
linkedList.append(3)
linkedList.append(4)
linkedList.append(5)

print(linkedList.printElements)

let node = linkedList.node(at: 0)
print("node at index: \(node?.value)")

//let removedNode = linkedList.removeNode(at: 4)
//print("removed item: \(removedNode?.value)")
//print(linkedList.printElements)

//linkedList.insertNode(at: 5, value: 6)
//print(linkedList.printElements)
