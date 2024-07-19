//
//  FunctionViewController.swift
//  MT_8829569
//
//  Created by user228630 on 7/4/23.
//

import UIKit

class FunctionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var inputValueA: UITextField!
    
    @IBOutlet weak var inputValueB: UITextField!
    
    @IBOutlet weak var outputTextHolder: UILabel!
    
    @IBOutlet weak var outputValueHolder: UILabel!
    
    // function for null or not check
    func nullCheckFunc() -> Bool{
        if (inputValueA.text == "" || inputValueB.text == ""){
            return true
        }
        else {
            return false
        }
        
    }
    
    // function for input validity check
    func inputValidityCheckFunc(input: String) -> Bool {
        for charac in input{
            if (!(charac >= "a" && charac <= "z" ) && !(charac >= "A" && charac <= "Z" )){
                return true
            }
        }
        return false
    }
    
    
    @IBAction func calculateHypot(_ sender: Any) {
        
        if(!inputValidityCheckFunc(input: inputValueA.text!) && !inputValidityCheckFunc(input: inputValueB.text!)){
            outputTextHolder.text = "invalid input for A and/or B"
            return
        }
        
        // checking null or not
        if(nullCheckFunc()){
            outputTextHolder.text = "A and B cannot be empty"
            return
        }
        
        // checking input validity for a
        if(!inputValidityCheckFunc(input: inputValueA.text!)){
            outputTextHolder.text = "invalid A value"
        }
        
        // checking input validity for b
        if(!inputValidityCheckFunc(input: inputValueB.text!)){
            outputTextHolder.text = "invalid B value"
        }
        
        // checking null and validation conditions and creating output
        if(!nullCheckFunc() && inputValidityCheckFunc(input: inputValueA.text!) && inputValidityCheckFunc(input: inputValueB.text!)){
            
            // storing inputs in variables
            let a = Float(inputValueA.text!)
            let b = Float(inputValueB.text!)
            
            // calculating hypotenuse
            let m = sqrt(Double((a! * a!) + (b! * b!)))
            
            outputTextHolder.text = "The value of C according to Pythagorean is: "
            outputValueHolder.text = String(m)
            
            
        }
        
    }
    
    // clear button function
     @IBAction func clearBtn(_ sender: Any) {
        outputTextHolder.text = "Enter a value for A and B to find C"
        outputValueHolder.text = ""
        inputValueA.text? = ""
        inputValueB.text? = ""
        
        
        
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
