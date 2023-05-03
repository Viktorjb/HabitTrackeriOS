//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-24.
//

import UIKit
import Firebase

class AddHabitViewController: UIViewController {
    
    var habits : HabitList?
    let db = Firestore.firestore()
    
    @IBOutlet weak var addTextField: UITextField!
    
    
    @IBAction func addHabitButton(_ sender: Any) {
        if let habitString = addTextField.text{
            let newHabit = Habit(name: habitString)
            habits?.add(habit: newHabit)
            addToFirestore(habit: newHabit)
            
            //return to previous view
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func addToFirestore(habit: Habit){
        do{
            try db.collection("habits").addDocument(from: habit)
        } catch{
            print("Error sending to Database")
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
