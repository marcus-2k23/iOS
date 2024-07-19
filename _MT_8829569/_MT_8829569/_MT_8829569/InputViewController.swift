//
//  InputViewController.swift
//  MT_8829569
//
//  Created by user228630 on 7/4/23.
//

import UIKit

class InputViewController: UIViewController {

    
    @IBOutlet weak var cityImageHolder: UIImageView!
    
    @IBOutlet weak var citySearchInput: UITextField!
    
    
    @IBOutlet weak var errorsHolder: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func citySearchBtn(_ sender: Any) {
        
        
        // checking what is the input and displaying that image
        if(citySearchInput.text?.lowercased() == "calgary"){
            cityImageHolder.image = UIImage(named: "Calgary")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        if(citySearchInput.text?.lowercased() == "halifax"){
            cityImageHolder.image = UIImage(named: "Halifax")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        if(citySearchInput.text?.lowercased() == "montreal"){
            cityImageHolder.image = UIImage(named: "Montreal")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        if(citySearchInput.text?.lowercased() == "toronto"){
            cityImageHolder.image = UIImage(named: "Toronto")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        if(citySearchInput.text?.lowercased() == "vancouver"){
            cityImageHolder.image = UIImage(named: "Vancouver")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        if(citySearchInput.text?.lowercased() == "winnipeg"){
            cityImageHolder.image = UIImage(named: "Winnipeg")
            // clearing errors
            errorsHolder.text = ""
            return
        }
        // if invalid input then showing error
        else{
            errorsHolder.text = "Invalid Input city name, try again"
        }
        
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
