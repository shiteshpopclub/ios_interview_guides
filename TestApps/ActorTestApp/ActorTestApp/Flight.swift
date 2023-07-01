//
//  Flight.swift
//  ActorTestApp
//
//  Created by Shitesh Patel on 26/06/23.
//

import Foundation

/*
 class Flight {
 var company: String {
 "Vistara"
 }
 var availableeats: [String] = ["1A", "1B", "1C", "1D"]
 let barrierQueue: DispatchQueue = DispatchQueue(label: "barrierQueue", attributes: .concurrent)
 
 func getAvailableSeats() -> [String] {
 barrierQueue.sync(flags: .barrier) {
 return availableeats
 }
 }
 
 func bookSeat() -> String {
 barrierQueue.sync(flags: .barrier) {
 let bookedSeat = availableeats.first ?? ""
 availableeats.removeFirst()
 return bookedSeat
 }
 }
 }
 */


actor Flight {
    nonisolated var company: String {
        "Vistara"
    }
    var availableSeats: [String] = ["1A", "1B", "1C", "1D"]

    func getAvailableSeats() -> [String] {
        return availableSeats
    }

    func bookSeat() -> String {
        let bookedSeat = availableSeats.removeFirst()
        return bookedSeat
    }
}
