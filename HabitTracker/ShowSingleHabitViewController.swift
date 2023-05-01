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
        
        let hasBeenDone = habit?.hasBeenDoneToday() ?? false
        if(hasBeenDone){
            doneButtonOutlet.setTitle("Already done", for: .normal)
        }
        
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
