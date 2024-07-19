//
//  ViewController.swift
//  Week01
//
//  Created by user228630 on 5/17/23.
//

import UIKit

class ViewController: UIViewController {

    var count = 0
    var stepper = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var counter: UILabel!
    
    @IBAction func decrement(_ sender: Any) {
                                                    // decrement button
        if stepper == true {
            count = count - 2                       // stepper toggle ON
            
            counter.text = String(count)
        }else{                                      //stepper toggle OFF
            count = count - 1
            counter.text = String(count)
        }
        
    }


    @IBAction func increment(_ sender: Any) {
                                                    // Increment Button
        if stepper == true{count = count + 2
            counter.text = String(count)}           // stepper toggle ON
        else{
            count = count + 1                      // Stepper toggle OFF
            counter.text = String(count)
        }
        
    }
    


    @IBAction func reset(_ sender: Any) {
                                                    // RESET button
        count = 0
        counter.text = String(count)
        
    }
    


    @IBAction func addtwo(_ sender: Any) {
                                                // Stepper button toggle
        if stepper == false {stepper = true
        }else {
            stepper = false
        }
    }
    


}

