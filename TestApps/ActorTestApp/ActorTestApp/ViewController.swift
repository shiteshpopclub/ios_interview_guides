//
//  ViewController.swift
//  ActorTestApp
//
//  Created by Shitesh Patel on 26/06/23.
//

import UIKit


public extension  UIResponder {
    func responderChain() ->String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + "->" + next.responderChain()
    }
}

class ViewController: UIViewController {

    @IBOutlet private weak var queueOneLbl: UILabel!
    @IBOutlet private weak var queueTwoLbl: UILabel!
    
    @IBOutlet weak var clickMeBtn: UIButton!
    
    var flag: Bool = false
    var secondVC: SecondViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        testBookFlight()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(#function)
        
        if flag {
            accessLbl()
        } else {
            flag = true
        }
    }
    
    
    func accessLbl() {
        
        print("secondVC:: \(secondVC)")
        
        secondVC?.testLbl.text = "Test lbl text"
        secondVC?.secondLbl.text = "Label has strong reference"
        
//        secondVC = nil
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
    
    @IBAction func clickMeDidTapped(_ sender: UIButton) {
        print(#function)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        secondVC = storyboard.instantiateViewController(withIdentifier: String(describing: SecondViewController.self)) as? SecondViewController
        navigationController?.pushViewController(secondVC!, animated: true)
    }
    
}

