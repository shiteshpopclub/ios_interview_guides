import UIKit


// 1. remove duplicate elements from sorted array


func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 1 else { return nums.count }

    var c = 0, n = 1
    
    while n < nums.count {
        if nums[c] != nums[n] {
            c += 1
            nums[c] = nums[n]
        }
        n += 1
    }

    return c + 1
}

var duplicateArray1:[Int] = [0,0,1,1,1,1,2,3,3,3,3,3]
let count1 = removeDuplicates(&duplicateArray1)
duplicateArray1.removeSubrange(count1..<duplicateArray1.count)
print("Array without duplicates: \(duplicateArray1)")




// 2. remove duplicate elements from sorted array but array can vontain max two duplicate elements

func removeMoreThanTwoDuplicates(_ nums: inout [Int]) -> Int {
    guard nums.count > 2 else { return nums.count }
    
    var c = 1, n = 1, dCount = 1
    
    while n < nums.count {
        
        if nums[n] == nums[n-1] {
            dCount += 1
        } else {
            dCount = 1
        }
        
        if dCount <= 2 {
            nums[c] = nums[n]
            c += 1
        }
        n += 1
    }
    
    return c
}

var duplicateArray:[Int] = [0,0,0,0,1,1,1,1,1,2,3,3,3,3,3,4,4,4,4,4]
let count = removeMoreThanTwoDuplicates(&duplicateArray)
duplicateArray.removeSubrange(count..<duplicateArray.count)
print("Array with only two duplicates: \(duplicateArray)")


/*
 3. Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.
 
 Example 1:
 
 Input: nums = [1,2,3,4,5,6,7], k = 3
 Output: [5,6,7,1,2,3,4]
 Explanation:
 rotate 1 steps to the right: [7,1,2,3,4,5,6]
 rotate 2 steps to the right: [6,7,1,2,3,4,5]
 rotate 3 steps to the right: [5,6,7,1,2,3,4]
 
 
 Trik: first reverse the array
       reverse first k element
       reverse last n - k elements
 */


func rotateArray(by steps: Int, nums: inout [Int]) {

    var i = 0
    let count = nums.count
    let k = steps % count
    
    //reverse the array
    reverse(&nums, 0, count-1)
    
    //reverse first k element
    reverse(&nums, 0, k-1)
    
    //reverse last (count-k) element
    reverse(&nums, k, count-1)
    
    func reverse(_ nums: inout [Int], _ start: Int, _ end: Int) {
        var start = start, end = end
        
        while start < end {
            let temp = nums[start]
            nums[start] = nums[end]
            nums[end] = temp

            start += 1
            end -= 1
        }
    }
}

var nums = [1,2,3,4,5,6,7]
rotateArray(by: 3, nums: &nums)
print("Rotated array: \(nums)")


/*
 Best Time to Buy and Sell Stock

You are given an array prices where prices[i] is the price of a given stock on the ith day.
You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.
Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

Example 1:

Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.

*/


func maxProfitToSellStock1(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }

        var maxProfit = 0, currentProfit = 0

        for i in 1..<prices.count {
            currentProfit  = max(0, currentProfit + prices[i] - prices[i-1])
            maxProfit = max(maxProfit, currentProfit)
        }

        return maxProfit
    }

let prices = [7,1,5,3,6,4,10]
let maxProfit = maxProfitToSellStock1(prices)
print("Max profit: \(maxProfit)")

/*
 Jump Game

 You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.
 Return true if you can reach the last index, or false otherwise.

 Example 1:

 Input: nums = [2,3,1,1,4]
 Output: true
 Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
 Example 2:

 Input: nums = [3,2,1,0,4]
 Output: false
 Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
 */

func canJump(_ nums: [Int]) -> Bool {
    var reach = 0
    var i = 0
    
    while i <= reach {
        reach = max(reach, i + nums[i])
        i += 1
        if reach >= nums.count - 1 { return true }
    }
    
    return false
}


/*
 Find second largest number in an array
 */

func findSecondLargest(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return 0 }

    var second = 0, first = 0

    for num in nums {
        if num > first {
            second = first
            first = num
        } else if num > second, num < first {
            second = num
        }
    }

    return second
}

print("Second largest:: \(findSecondLargest(nums))")
