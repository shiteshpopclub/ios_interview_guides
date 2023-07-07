import UIKit

class Node<T: Equatable> {
    var value: T
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
        self.next = nil
    }
}

class LinkedList<T: Equatable> {
    var head: Node<T>?
    var tail: Node<T>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    var first: Node<T>? {
        return head
    }
    
    var last: Node<T>? {
        return tail
    }

    var count: Int {
        guard head != nil else { return 0 }
        
        var current = head
        var i = 1
        
        while current?.next != nil {
            i += 1
            current = current?.next
        }
    
        return i
    }

    func append(value: T) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
            tailNode.next = newNode
            tail = newNode
        } else {
            head = newNode
            tail = newNode
        }
    }
    
    func node(atIndex index: Int) -> Node<T>? {
        guard index >= 0 else {
            return nil
        }
        
        var node = head
        var i = 0

        while node != nil {
            if i == index { return node }

            i += 1
            node = node?.next
        }
        
        return node
    }
    
    func insert(value: T, atIndex index: Int) {
        let newNode = Node(value: value)

        if index == 0 {
            newNode.next = head
            head = newNode
            if tail == nil {
                tail = newNode
            }
        } else {
            let prevNode = node(atIndex: index - 1)
            let nextNode = prevNode?.next

            prevNode?.next = newNode
            newNode.next = nextNode

            if prevNode === tail {
                tail = newNode
            }
        }
    }
    
    func remove(atIndex index: Int) -> T? {
        var value: T? = nil

        if index == 0 {
            value = head?.value
            head = head?.next
            if head == nil {
                tail = nil
            }
        } else {
            let prevNode = node(atIndex: index - 1)
            let nodeToRemove = prevNode?.next
            let nextNode = nodeToRemove?.next

            value = nodeToRemove?.value

            prevNode?.next = nextNode

            if nodeToRemove === tail {
                tail = prevNode
            }
        }

        return value
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    func printList() {
        var current = head
        
        while current != nil {
            print(current!.value, terminator: " ")
            current = current!.next
        }
        
        print()
    }
}

// Create a new linked list
let list = LinkedList<Int>()

// Append elements
list.append(value: 1)
list.append(value: 2)
list.append(value: 3)
list.append(value: 4)
list.append(value: 5)
list.append(value: 6)
list.append(value: 7)
list.append(value: 8)

list.printList()

//let node = list.node(atIndex: 2)
//print(node?.value)
//
//// Insert an element at index 1
//list.insert(value: 5, atIndex: 1)
//
//list.printList()
//
//// Remove an element at index 2
//list.remove(atIndex: 2)
//
//// Print the elements of the linked list
//list.printList()



/*
 find the middle element in the linked list
 */


func findMiddleElement(_ list: LinkedList<Int>) -> Node<Int>? {
    guard !list.isEmpty, list.count > 2 else { return nil }
    
    var slow: Node<Int>? = list.first
    var fast: Node<Int>? = list.first
    
    while fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    return slow
}

//print("middle element:: \(findMiddleElement(list)?.value)")

/*
 Delete odd index elements from a linked list
 */


func deleteOddIndexElement(_ list: LinkedList<Int>) {
    guard !list.isEmpty else { return }
    
    var current = list.first
    
    // remove first element
    list.head = current?.next
    current = current?.next
    
    while current?.next != nil {
        current?.next = current?.next?.next
        current = current?.next
    }
}


//print("List before deleting odd index element")
//list.printList()

//deleteOddIndexElement(list)
//
//print("List after deleting odd index element")
//list.printList()


/*
 Delete middle of linked list
 */

func deleteMiddleElement(_ list: LinkedList<Int>) {
    guard !list.isEmpty, list.count > 2 else { return }

    var prev: Node<Int>? = nil
    var slow: Node<Int>? = list.first
    var fast: Node<Int>? = list.first
    
    while fast?.next != nil {
        prev = slow
        slow = slow?.next
        fast = fast?.next?.next
    }

    prev?.next = prev?.next?.next
}

//deleteMiddleElement(list)
//print("List after deleting middle element")
//list.printList()


/*
 Reverse a linked list
 */

func reverseALinkedList(_ list: LinkedList<Int>) {
    guard !list.isEmpty, let node = list.first, node.next != nil else {
        return
    }

    var prev: Node<Int>? = nil
    var current: Node<Int>? = list.first
    var next: Node<Int>?
    
    while current != nil {
        next = current?.next

        current?.next = prev
        prev = current
        current = next
    }
    
    list.head = prev
}

reverseALinkedList(list)
print("List after reversing the elements")
list.printList()


/*
 Find nth node from the end of linked list
 */
