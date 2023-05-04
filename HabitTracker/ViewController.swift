//
//  ViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    //Main model object
    var habits = HabitList()
    //Database
    let db = Firestore.firestore()
    //Segue identifier
    let tableViewSegue = "tableViewSegue"
    
    var signedIn = false
    
    @IBOutlet weak var bestStreaksTextView: UITextView!
    @IBOutlet weak var toListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bestStreaksTextView.text = "Signing in..."
        var auth = Auth.auth()
        auth.signInAnonymously { result, error in
            if let error = error {
                print("Error signing in: \(error)")
            } else {
                self.signedIn = true
                self.habits.listenToFirestore()
                self.bestStreaksTextView.text = "Succesfully signed in!"
            }
            
        }
        
    }
    
    //If we're properly signed in, write out best streaks
    override func viewWillAppear(_ animated: Bool) {
        if(signedIn){
            updateStreakList()
        }
    }
    
    //Write out best streaks
    func updateStreakList(){
        var bestStreakText = "Best streaks:\n"
        let streakList = habits.bestStreaks()
        for habit in streakList{
            bestStreakText.append("\n" + habit.name + ": " + String(habit.streak))
        }
        bestStreaksTextView.text = bestStreakText
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == tableViewSegue){
            let vc = segue.destination as! TableViewController
            vc.habits = habits
        }
    }


}

