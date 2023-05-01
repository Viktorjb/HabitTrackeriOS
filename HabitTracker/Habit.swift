//
//  Habit.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-24.
//

import Foundation

class Habit {
    
    //Name of the habit
    let name : String
    //A list of dates this habit has been performed
    //Dates will be strings in the format of yyyy/MM/dd
    var performedList : [String]
    var streak : Int
    
    let dateFormatter = DateFormatter()
    
    init(name: String) {
        self.name = name
        self.performedList = [String]()
        self.streak = 0
        self.dateFormatter.dateFormat = "yyyy/MM/dd"
    }
    
    //also needs another init for creating from database (firebase)
    
    //Add today to the list of dates, i.e. the habit has been performed today
    func doneToday(){
        if(performedList.contains(dateFormatter.string(from: Date()))){
            return
        }
        performedList.append(dateFormatter.string(from: Date()))
    }
    
    //returns if the habit has been done today (as bool)
    func hasBeenDoneToday() -> Bool {
        return performedList.contains(dateFormatter.string(from: Date()))
    }
    
    //Calculate the current streak (from today or yesterday)
    func updateStreak(){
        //Keeping track of the date during the while-loop
        var dateStep = dateFormatter.string(from: Date())
        //If today exists in the list, add 1 to the streak, else start at 0
        if(performedList.contains(dateFormatter.string(from: Date()))){
            streak = 1
        } else{
            streak = 0
        }
        //Count backwards "recursively" until "yesterday" doesn't exist in the list
        while(true){
            dateStep = yesterday(day: dateStep)
            if(performedList.contains(dateStep)){
                streak = streak + 1
            } else{
                break
            }
        }
    }
    
    //Returns the "date" before the date given
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

    
}
