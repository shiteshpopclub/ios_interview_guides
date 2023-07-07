import UIKit

class Node<T: Equatable> {
    var value: T
    var next: Node<T>?

    init(_ value: T) {
        self.value = value
        self.next = nil
    }
}

class LinkedList<T: Equatable> {
    private var head: Node<T>?

    func isEmpty() -> Bool {
        return head == nil
    }

    func append(_ value: T) {
        let newNode = Node(value)
        if head == nil {
            head = newNode
        } else {
            var current = head
            while current?.next != nil {
                current = current?.next
            }
            current?.next = newNode
        }
    }

    func remove(_ value: T) {
        if head?.value == value {
            head = head?.next
        } else {
            var current = head
            var prev: Node<T>?

            while current != nil && current?.value != value {
                prev = current
                current = current?.next
            }

            prev?.next = current?.next
        }
    }

    func printList() {
        var current = head
        while current != nil {
            print(current!.value, terminator: " ")
            current = current?.next
        }
        print()
    }
}


let list = LinkedList<Int>()

list.append(1)
list.append(2)
list.append(3)

list.printList() // Output: 1 2 3

list.remove(2)

list.printList() // Output: 1 3
