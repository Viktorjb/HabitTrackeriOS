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
    var performedList = [Date]()
    
    init(name: String) {
        self.name = name
    }
    
    
}
