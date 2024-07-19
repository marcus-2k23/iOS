//
//  ViewController.swift
//  Week03
//
//  Created by user228630 on 5/24/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var userMessage: UILabel!
    @IBOutlet weak var allData: UITextView!
    @IBOutlet weak var firstNameOut: UITextField!
    @IBOutlet weak var lastNameOut: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    @IBOutlet weak var countryNameOut: UITextField!
    
    
    @IBAction func firstName(_ sender: UITextField) {
    }
    @IBAction func lastName(_ sender: UITextField) {
    }
    @IBAction func country(_ sender: UITextField) {
    }
    @IBAction func age(_ sender: UITextField) {
    }
   
    
    @IBAction func add(_ sender: UITextField) {
        allData.text = "Full Name: \(firstNameOut.text!) \(lastNameOut.text!) \nCountry: \(countryNameOut.text!) \nAge: \(ageOutlet.text!)"
    }
    
    @IBAction func submit(_ sender: Any) {
        if(firstNameOut.text==nil||firstNameOut.text!.isEmpty||lastNameOut.text==nil||lastNameOut.text!.isEmpty||countryNameOut.text==nil||countryNameOut.text!.isEmpty||ageOutlet.text!.isEmpty||ageOutlet.text!.isEmpty){
            
            userMessage.text="Complete the missing info"
        }else {
            userMessage.text = "Successfully Submitted"
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        firstNameOut.text=""
        lastNameOut.text=""
        countryNameOut.text=""
        ageOutlet.text=""
        allData.text=""
        userMessage.text=""
    }
    
    
    
    
}

