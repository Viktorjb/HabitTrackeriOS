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
    
    let db = Firestore.firestore()
    
    let tableViewSegue = "tableViewSegue"
    
    @IBOutlet weak var bestStreaksTextView: UITextView!
    @IBOutlet weak var toListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        habits.listenToFirestore()
        //habits.writeToFirestore()
        //Write out best streaks
        updateStreakList()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let theDate = Date()
        let dateString = dateFormatter.string(from: theDate)
        print(dateString)
        print(yesterday(day:dateString))
        print(yesterday(day: "2023/03/01"))
        print(yesterday(day: "2023/03/01"))
        print(yesterday(day: "2021/02/02"))
        print(yesterday(day: "2017/01/01"))
        print(yesterday(day: "2023/06/30"))
        print(yesterday(day: "2023/08/01"))
        
        print("----")
        
        var dateStringList = [String]()
        dateStringList.append("2023/08/01")
        dateStringList.append("2023/08/04")
        dateStringList.append("2023/07/01")
        dateStringList.append("2023/07/02")
        dateStringList.append("2022/07/02")
        dateStringList.append("2022/08/04")
        
        for index in dateStringList{
            print(index)
        }
        
        print("----")
        
        dateStringList = dateStringList.sorted()
        
        for index in dateStringList{
            print(index)
        }
        
        print("----")
        
        let habitTest = Habit(name: "Sleep")
        
        habitTest.updateStreak()
        
        print(String(habitTest.streak))
        
        habitTest.doneToday()
        habitTest.performedList.append("2023/04/26")
        habitTest.performedList.append("2023/04/25")
        habitTest.performedList.append("2023/04/24")
        habitTest.performedList.append("2023/04/22")
        
        habitTest.updateStreak()
        
        print(String(habitTest.streak))
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateStreakList()
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
    
    func yesterday(day: String) -> String{
        //Convert Year/Month/Day to integers
        var yearInt = Int(day.prefix(4)) ?? 11
        var monthInt = Int(day.suffix(5).prefix(2)) ?? 11
        var dayInt = Int(day.suffix(2)) ?? 11
        
        
        //handle going back a day
        
        dayInt = dayInt - 1
        if(dayInt < 1){
            monthInt = monthInt - 1
            
            if(monthInt < 1){
                yearInt = yearInt - 1
                monthInt = 12
            }
            
            if(monthInt == 1 || monthInt == 3 || monthInt == 5 || monthInt == 7 || monthInt == 8 || monthInt == 10 || monthInt == 12 ){
                dayInt = 31
            } else if(monthInt == 2){
                dayInt = 28
            } else{
                dayInt = 30
            }
            
        }
        
        
        //Convert integers back to formatted string
        let yearString = String(yearInt)
        var monthString = String(monthInt)
        if(monthString.count < 2){
            monthString = "0" + monthString
        }
        var dayString = String(dayInt)
        if(dayString.count < 2){
            dayString = "0" + dayString
        }
        let newString = yearString + "/" + monthString + "/" + dayString
        
        return newString
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

