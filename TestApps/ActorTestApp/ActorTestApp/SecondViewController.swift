//
//  SecondViewController.swift
//  ActorTestApp
//
//  Created by Shitesh Patel on 09/07/23.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var testLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(#function)
        testLbl.text = "Test lbl text"
        secondLbl.text = "Label has strong reference"
        self.view.backgroundColor = .cyan
    }
    

    deinit {
        print("deint \(String(describing: SecondViewController.self))")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
