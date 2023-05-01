//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-24.
//

import UIKit

class AddHabitViewController: UIViewController {

    var habits : HabitList?
    
    @IBOutlet weak var addTextField: UITextField!
    
    
    @IBAction func addHabitButton(_ sender: Any) {
        if let habitString = addTextField.text{
            habits?.add(habit: Habit(name: habitString))
            print("ADDED" + habitString)
            //return to previous view
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
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
