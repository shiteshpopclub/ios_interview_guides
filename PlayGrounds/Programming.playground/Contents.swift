import UIKit



/*
 1. Find GCD of two numbers
 */

func findGCD(_ first: Int, _ second: Int) -> Int {
    guard first != second else { return first }

    var greater = first, smaller = second
    
    if second > first {
        greater = second
        smaller = first
    }

    var r: Int
    repeat {
        r = greater % smaller
        if r != 0 {
            greater = smaller
            smaller = r
        }
    } while (r != 0)

    return smaller
}

let gcd = findGCD(20, 8)
print("gcd: \(gcd)")


/*
struct Address {
  var fullAddress: String
  var city: String
  
  init(fullAddress: String, city: String) {
    self.fullAddress = fullAddress
    self.city = city
  }
}

class Person {
  var name: String
  var address: Address
  
  init(name: String, address: Address) {
    self.name = name
    self.address = address
  }
}

var headquarters = Address(fullAddress: "123 Tutorial Street", city: "Appletown")
var ray = Person(name: "Ray", address: headquarters)
var brian = Person(name: "Brian", address: headquarters)

ray.address.fullAddress = "444 Tutorial Street"

print("ray: \(ray.address.fullAddress)")
print("brian: \(brian.address.fullAddress)")

var thing = "cars"

let closure = { [thing] in
  print("I love \(thing)")
}

thing = "airplanes"

closure()


struct Student {
    let name: String
    let score: Double
}

struct StudentViewModel {
    
    var students: [Student]
    
    lazy var topperByLazy: Student? = {
        print("calculating topper by lazy property")
        return students.max(by: { $0.score < $1.score } )
    }()
    
    var topperByComputed: Student? {
        print("calculating topper by computed property")
        return students.max(by: { $0.score < $1.score } )
    }
    
    init(studentArray: [Student]) {
        self.students = studentArray
    }
}

var viewModel = StudentViewModel(studentArray: [Student(name: "Charlie", score: 7.9),
                                                Student(name: "Josh", score: 8.5),
                                                Student(name: "Alex", score: 9.1),
                                                Student(name: "Tina", score: 9.0)])

let _ = viewModel.topperByLazy
let _ = viewModel.topperByLazy
let _ = viewModel.topperByComputed
let _ = viewModel.topperByComputed


print("Top score: \(viewModel.topperByLazy?.score ?? 0.0)")
// calculating topper by lazy property
// Top score: 9.1

viewModel.students.append(Student(name: "Elena", score: 9.5))

print("Top score: \(viewModel.topperByLazy?.score ?? 0.0)")
// Top score: 9.1 // Wrong score, it should be 9.5

public struct Thermometer {
  public var temperature: Double
  public init(temperature: Double) {
    self.temperature = temperature
  }
}

let th: Thermometer = Thermometer(temperature: 23.7)
print("th temperature: \(th.temperature)")

extension Thermometer: ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        temperature = value
    }
}

let th1: Thermometer = 47.6
print("th1 temperature: \(th1.temperature)")




struct Pizza {
  let ingredients: [String]
}

protocol Pizzeria {
  func makePizza(_ ingredients: [String]) -> Pizza
  func makeMargherita() -> Pizza
}

extension Pizzeria {
  func makeMargherita() -> Pizza {
    return makePizza(["tomato", "mozzarella"])
  }
}

struct Lombardis: Pizzeria {
  func makePizza(_ ingredients: [String]) -> Pizza {
    return Pizza(ingredients: ingredients)
  }

  func makeMargherita() -> Pizza {
    return makePizza(["tomato", "basil", "mozzarella"])
  }
}

let lombardis1: Pizzeria = Lombardis()
let lombardis2: Lombardis = Lombardis()

print(lombardis1.makeMargherita())
print(lombardis2.makeMargherita())
*/



let firstArray = [1, 2, 3, 5, 7, 6, 8, 9, 10, 4]
let secondArray = [1, 3, 5, 11, 12]
let common1 = firstArray.filter { secondArray.contains($0) }
print(common1)

let codes = [["abc","def","ghi"],["jkl","mno","pqr"]]
let newCodes = codes.flatMap { $0 }
print("newCodes: \(newCodes)")
let newCodes1 = codes.flatMap { $0.map{ $0.uppercased() } }
print("newCodes: \(newCodes1)")


class Increment {
    var number = 0
    var marks = [10, 60, 20, 40, 80, 90]

     deinit {
        print(#function)
    }
    
    lazy var incrementNumber: (Int) -> () = { [weak self] value in
        guard let `self` = self else { return }

        self.number += value
        print(self.number)
    }

    lazy var maxMark: Int = {
        print("calculate max mark")
        var max = Int.min
        for mark in marks {
            if mark > max {
                max = mark
            }
        }
        print("max: \(max)")

        return max
    }()
}

var increment: Increment? = Increment()
increment?.incrementNumber(3)
print("maxMark:  \(String(describing: increment?.maxMark))")
increment?.marks.append(100)
print("maxMark:  \(String(describing: increment?.maxMark))")

increment = nil

var increment2: () = Increment().incrementNumber(3)
//increment2 = nil


/*
 Merge sort
 */

func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArray: [T] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            orderedArray.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            orderedArray.append(rightElement)
            rightIndex += 1
        } else {
            orderedArray.append(leftElement)
            leftIndex += 1
            orderedArray.append(rightElement)
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArray
}

print("SortedArray: \(mergeSort([4, 6, 1, 8, 2, 3, 5, 9, 8]))")
print("SortedArray: \(mergeSort([4, 6, 1, 8, 2, 3, 5, 9, 8, 10]))")

/*
 Fild all possible meaningful words
 */
func findPossibleWords(_ word: String) -> [String] {
    let validWords = ["cat", "dog", "act", "god", "tac", "dot", "chess", "sechs"] // Replace with your dictionary of valid words
    var possibleWords: [String] = []
    let sortedWord = word.sorted() // Sort the characters of the given word

    for validWord in validWords {
        let sortedValidWord = validWord.sorted() // Sort the characters of each valid word
        if sortedWord == sortedValidWord {
            possibleWords.append(validWord) // Add the word to the list of possible words
        }
    }
    return possibleWords
}

// Example usage:
var possibleWords = findPossibleWords("tac")
print(possibleWords) // Output: ["cat", "act", "tac"]
possibleWords = findPossibleWords("god")
print(possibleWords) // Output: ["god", "dog"]
print(findPossibleWords("chess"))


/*
 Two sum probles
 
 identify the pairs that sum is equal to given sum
 */


func findPairsForSum(inputArray: [Int], sum: Int) {
    var dict = [Int : Int]()
    
    for item in inputArray {
        let diff = sum - item
        if dict[diff] != nil, dict[item] == nil {
            print("(\(item)  \(diff))")
        }
        
        dict[item] = item
    }
}


let input1 = [1, 2, 6, 8, 4]
let input2 = [1, 2, 6, 8, 4, 6, 4, 3, 7, 5, 5, 5, 9, 9]
findPairsForSum(inputArray: input2, sum: 10)

/* return first pair of index only*/

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var map: [Int : Int] = [:]
    var result: [Int] = []
    
    for (i, num) in nums.enumerated() {
        let diff = target - num
        
        if map[diff] != nil, map[num] == nil, let prevIndex = map[diff] {
            result.append(prevIndex)
            result.append(i)
            break
        }
        
        map[num] = i
    }
    
    return result
}

print(twoSum(input1, 10))

/*
 Longest Substring Without Repeating Characters

 Input: s = "abcabcbb"
 Output: abc
 */


func lengthOfLongestSubstring(_ s: String) -> String? {
    guard !s.isEmpty else { return nil }
    
    var chs = [Character]()
    var longestSubstring = ""

    for c in s {
        if let index = chs.firstIndex(of: c) {
            let subString = String(chs)
            if subString.count > longestSubstring.count {
                longestSubstring = subString
            }

            chs.removeSubrange(0...index)
        }

        chs.append(c)
    }

    return longestSubstring
}

print(lengthOfLongestSubstring("abcdcab"))
print(lengthOfLongestSubstring("abcdaghikghijkli"))

/*
 Median of Two Sorted Arrays

 Example 1:

 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.
 Example 2:

 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
 */

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var result: Double = 0.0
    var finalArray: [Int] = []
    
    var n1 = 0, n2 = 0
    
    while n1 < nums1.count, n2 < nums2.count {
        if nums1[n1] < nums2[n2] {
            finalArray.append(nums1[n1])
            n1 += 1
        } else {
            finalArray.append(nums2[n2])
            n2 += 1
        }
    }
    
    while n1 < nums1.count {
        finalArray.append(nums1[n1])
        n1 += 1
    }
    
    while n2 < nums2.count {
        finalArray.append(nums2[n2])
        n2 += 1
    }
    
    
    let midIndex = finalArray.count / 2

    if finalArray.count == 2 {
        result = Double(finalArray[midIndex - 1] + finalArray[midIndex]) / 2.0
    } else if midIndex > 0, finalArray.count % 2 == 0 { // even number
        result = Double(finalArray[midIndex - 1] + finalArray[midIndex]) / 2.0
    } else { // odd number
        result = Double(finalArray[midIndex])
    }

    return result
}

print(findMedianSortedArrays([1,3], [2]))
print(findMedianSortedArrays([1,2], [3, 4]))
print(findMedianSortedArrays([], [1]))
print(findMedianSortedArrays([], [2, 3]))
print(findMedianSortedArrays([], [1, 2, 3, 4, 5]))


/*
 Reverse Integer

 Example 1:

 Input: x = 123
 Output: 321
 Example 2:

 Input: x = -123
 Output: -321
 Example 3:

 Input: x = 120
 Output: 21
 */


func reverseNumber(_ num: Int) -> Int {
    var rev = 0
    
    var number = num
    repeat {
        let rem = number % 10
        
        rev = rev*10 + rem
        number = number / 10
        
    } while (number != 0)

    return rev
}

print(reverseNumber(123))
print(reverseNumber(-123))
print(reverseNumber(120))

/*
 program to implemet pow(b, n)
 */


func myPow(_ x: Double, _ n: Int) -> Double {
    guard n != 0 else { return 1 }

    var base = x, power = n, result: Double = 1.0
    
    if power < 0 {
        base = 1.0/base
        power = -power
    }

    while power > 0 {
        if power % 2 != 0 {
            result *= base
        }
        
        base *= base
        power /= 2
    }

    return result
}

print("pow(10, 2) = \(myPow(2.0, 10))")

/*
 Climbing Stairs

 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Example 1:

 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 Example 2:

 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 */

func climbStairs(_ n: Int) -> Int {
    guard n > 0 else { return 0 }
    guard n != 1 else { return 1 }

    var f = 1, s = 1, t = 0, i = 2
    
    while i <= n {
        t = f + s
        f = s
        s = t
        i += 1
    }

    return s
}

print(climbStairs(5))





