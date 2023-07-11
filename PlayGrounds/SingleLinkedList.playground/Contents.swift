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

    /*
     find the middle element in the linked list
     */


    func findMiddleElement() -> Node<Int>? {
        guard !list.isEmpty, list.count > 2 else { return nil }
        
        var slow: Node<Int>? = list.first
        var fast: Node<Int>? = list.first
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }

    /*
     Delete odd index elements from a linked list
     */

    func deleteOddIndexElement() {
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
    
    /*
     Delete middle of linked list
     */

    func deleteMiddleElement() {
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
    
    /*
     Reverse a linked list
     */

    func reverseALinkedList() {
        guard !list.isEmpty, let node = list.first, node.next != nil else {
            return
        }

        var prev: Node<Int>? = nil
        var current: Node<Int>? = list.first
        
        while current != nil {
            let next = current?.next

            current?.next = prev
            prev = current
            current = next
        }
        
        list.head = prev
    }
    
    /*
     Find nth node from the end of linked list
     */

    func findNthNodeFromEnd(_ n: Int) -> Node<T>? {
        guard list.head != nil, n > 0 else { return nil }

        var slow: Node<T>? = first
        var fast: Node<T>? = first
        
        // first move fast index with n position ahead
        for _ in 0..<n {
            if fast == nil {// index outside list
                return nil
            }
            
            fast = fast?.next
        }

        while fast != nil {
            fast = fast?.next
            slow = slow?.next
        }
        
        return slow
    }
    
    /*
     check whether singly linked list is a palindrom
     */

    func isPalindromLinkedList() -> Bool {
        guard list.head != nil else { return false }
        guard list.head?.next != nil else { return true }

        // first find mid of element, slow will be the mid
        var slow: Node<T>? = first
        var fast: Node<T>? = first
        
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        
        //reverse second half of list
        var prev: Node<T>? = nil
        var curr: Node<T>? = slow?.next
        
        while curr != nil {
            let next = curr?.next
            
            curr?.next = prev
            prev = curr
            curr = next
        }

        // compare first half with reversed second half
        var p1: Node<T>? = first
        var p2: Node<T>? = prev
        
        while p2 != nil {
            if p1?.value != p2?.value {
                return false
            }
            
            p1 = p1?.next
            p2 = p2?.next
        }

        return true
    }
    
    func deleteLastOccuranceOfAnAlement(_ element: T) {
        guard !isEmpty else { return }

        //find last occurance
        var prev: Node<T>? = nil
        var curr: Node<T>? = first
        var lastOcc: Node<T>? = nil
        
        //check for first node
        if first?.value == element {
            lastOcc = first
        }
        
        while curr?.next != nil {
            if curr?.next?.value == element {
                prev = curr
                lastOcc = curr?.next
            }

            curr = curr?.next
        }
        
        if lastOcc != nil {
            if lastOcc === first {// remove first element
                head = lastOcc
            } else {
                prev?.next = lastOcc?.next
            }
        }
        
    }
}

// Create a new linked list
let list = LinkedList<Int>()

// Append elements
list.append(value: 1)
list.append(value: 3)
list.append(value: 5)
list.append(value: 7)
list.append(value: 9)
list.append(value: 11)
list.append(value: 13)
list.append(value: 15)

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


//print("middle element:: \(list.findMiddleElement()?.value)")


//print("List before deleting odd index element")
//list.printList()

//list.deleteOddIndexElement()
//
//print("List after deleting odd index element")
//list.printList()


//list.deleteMiddleElement()
//print("List after deleting middle element")
//list.printList()


//list.reverseALinkedList()
//print("List after reversing the elements")
//list.printList()


//print("2nd element from last: \(list.findNthNodeFromEnd(2)?.value)")


//print(list.isPalindromLinkedList())


//list.deleteLastOccuranceOfAnAlement(4)
//list.printList()


func mergeTwoLinkedListWithAlternateValues(list1: LinkedList<Int>?, list2: LinkedList<Int>?) {
    if list1 == nil, list2 == nil {
        return
    } else if list1 == nil {
        list2?.printList()
        return
    } else if list2 == nil {
        list1?.printList()
        return
    }

    var l1Current: Node<Int>? = list1?.first
    var l1Next: Node<Int>? = l1Current?.next

    var l2Current: Node<Int>? = list2?.first
    var l2Next: Node<Int>? = l2Current?.next

    while l1Current != nil, l2Current != nil {
        if l2Current != nil {
            l1Current?.next = l2Current
        }
        
        if l1Next != nil {
            l2Current?.next = l1Next
        }

        l1Current = l1Next
        l1Next = l1Next?.next
        l2Current = l2Next
        l2Next = l2Next?.next
    }

    print("list after merg")
    list1?.printList()
}

let list1 = LinkedList<Int>()

// Append elements
list1.append(value: 2)
list1.append(value: 4)
list1.append(value: 6)
list1.append(value: 8)
list1.append(value: 10)
list1.append(value: 12)

//mergeTwoLinkedListWithAlternateValues(list1: list, list2: nil)
//mergeTwoLinkedListWithAlternateValues(list1: nil, list2: list1)
mergeTwoLinkedListWithAlternateValues(list1: list, list2: list1)
