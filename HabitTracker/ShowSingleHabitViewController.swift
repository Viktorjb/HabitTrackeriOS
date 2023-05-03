//
//  ShowSingleHabitViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-05-01.
//

import UIKit

class ShowSingleHabitViewController: UIViewController {

    var habit : Habit?
    
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var habitNameTextView: UITextView!
    @IBOutlet weak var habitStreakLabel: UILabel!
    @IBOutlet weak var statsTextView: UITextView!
    
    //Handle button tap, if habit hasn't been done today, if it has do nothing
    @IBAction func doneButton(_ sender: Any) {
        let hasBeenDone = habit?.hasBeenDoneToday() ?? false
        if(!hasBeenDone){
            habit?.doneToday()
            habit?.updateStreak()
            //return to previous view
            navigationController?.popViewController(animated: true)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
