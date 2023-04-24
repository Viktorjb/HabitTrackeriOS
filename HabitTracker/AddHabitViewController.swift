//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-24.
//

import UIKit

class AddHabitViewController: UIViewController {

    var mockList = [Habit]()
    
    @IBOutlet weak var addTextField: UITextField!
    
    
    @IBAction func addHabitButton(_ sender: Any) {
        if let habitString = addTextField.text{
            mockList.append(Habit(name: habitString))
            print("ADDED" + habitString)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
