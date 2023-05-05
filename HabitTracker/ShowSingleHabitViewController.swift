//
//  ShowSingleHabitViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-05-01.
//

import UIKit
import Firebase

class ShowSingleHabitViewController: UIViewController {

    var habit : Habit?
    var habits : HabitList?
    var index : Int?
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var habitNameTextView: UITextView!
    @IBOutlet weak var habitStreakLabel: UILabel!
    @IBOutlet weak var statsTextView: UITextView!
    @IBOutlet weak var deleteButtonOutlet: UIBarButtonItem!
    
    
    
    //Handle button tap, if habit hasn't been done today, if it has do nothing
    @IBAction func doneButton(_ sender: Any) {
        let hasBeenDone = habit?.hasBeenDoneToday() ?? false
        if(!hasBeenDone){
            habit?.doneToday()
            habit?.updateStreak()
            updateFirestoreDoc()
            //return to previous view
            navigationController?.popViewController(animated: true)
        }
    }
    
    //handle delete button
    @IBAction func deleteButton(_ sender: Any) {
        if let removeIndex = index{
            habits?.removeAt(index: removeIndex)
            removeFirestoreDoc()
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        habitNameTextView.text = habit?.name
        if let streakNumber = habit?.streak {
            habitStreakLabel.text = String(streakNumber)
        }
        
        let hasBeenDone = habit?.hasBeenDoneToday() ?? false
        if(hasBeenDone){
            doneButtonOutlet.setTitle("Already done today", for: .normal)
        }
        
        loadStats()
        // Do any additional setup after loading the view.
    }
    
    //Update the stats at the bottom of the page
    func loadStats(){
        let topStreak = habit?.bestStreak ?? 0
        let lastDate = habit?.performedList.sorted().first ?? "Never completed"
        
        statsTextView.text = "Best streak: " + String(topStreak) +
        "\nLast completed: " + lastDate
        
    }
    
    //remove document from firestore
    func removeFirestoreDoc(){
        guard let user = auth.currentUser else {return}
        let habitsRef = db.collection("users").document(user.uid).collection("habits")
        
        if let id = habit?.id{
            habitsRef.document(id).delete() { err in
                if let err = err {
                    print("Error deleting: \(err)")
                }
            }
        }
    }
    
    //update the firestore document
    func updateFirestoreDoc(){
        guard let user = auth.currentUser else {return}
        let habitsRef = db.collection("users").document(user.uid).collection("habits")
        
        if let id = habit?.id{
            habitsRef.document(id).updateData(["performedList": habit?.performedList])
            habitsRef.document(id).updateData(["streak": habit?.streak])
            habitsRef.document(id).updateData(["bestStreak": habit?.bestStreak])
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
