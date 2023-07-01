//
//  ViewController.swift
//  ActorTestApp
//
//  Created by Shitesh Patel on 26/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var queueOneLbl: UILabel!
    @IBOutlet private weak var queueTwoLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testBookFlight()
    }

    func testBookFlight() {
        let flight: Flight = Flight()

        let queue1: DispatchQueue = DispatchQueue(label: "queue1")
        let queue2: DispatchQueue = DispatchQueue(label: "queue2")

        queue1.async {
            Task { [weak self] in
                let bookedSeat = await flight.bookSeat()
                print("Booked seat: \(flight.company) \(bookedSeat)")
                self?.updateLabelText(flight.company, bookedTicket: bookedSeat)
            }
        }

        queue2.async {
            Task {
                print("Available seats: \(await flight.getAvailableSeats())")
            }
        }
    }

    @MainActor
    func updateLabelText(_ company: String, bookedTicket: String) {
        queueOneLbl.text = company
        queueTwoLbl.text = bookedTicket
    }
}

