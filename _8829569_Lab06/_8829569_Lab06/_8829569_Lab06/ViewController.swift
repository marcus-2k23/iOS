//
//  ViewController.swift
//  8829569_Lab06
//
//  Created by user228630 on 6/15/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var toDoTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.toDoTable.delegate = self
        self.toDoTable.dataSource = self
    }
    
    var myGarage: [String] = ["KIA","VW","HONDA","TOYOTA","FORD"]
    

    @IBAction func createButton(_ sender: Any) {
        
        let alertBox = UIAlertController(title: "Add Item",
                                          message: "Add Item", preferredStyle: .alert)
            
        alertBox.addTextField{(textField : UITextField!) -> Void in textField.placeholder = "Enter your Text Here"}
        
        alertBox.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertBox.addAction(UIAlertAction (title: "Ok", style: .default, handler: {alert -> Void in let textFieldOne = alertBox.textFields![0] as UITextField
            
            
            let newInputData = textFieldOne.text
            if(newInputData!.isEmpty){
                return
            }
            self.myGarage.append(newInputData!)
            self.toDoTable.reloadData()
            
            
        }))
        present(alertBox, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // #warning Incomplete implementation, return the number of sections
       return 1
   }
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myGarage.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "basicCar", for: indexPath)
       
       cell.textLabel?.text = myGarage[indexPath.row]
       
       return cell
   }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.myGarage.remove(at: indexPath.row)
            self.toDoTable.reloadData()
        }
    }
    
}

