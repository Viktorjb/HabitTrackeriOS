//
//  HabitList.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-25.
//

import Foundation

class HabitList {
    private var habits = [Habit]()
    
    init(){
        add(habit: Habit(name: "breathe"))
        add(habit: Habit(name: "sleep"))
    }
    
    var count : Int {
        return habits.count
    }
    
    func add(habit : Habit){
        habits.append(habit)
    }
    
    func getHabit(index : Int) -> Habit?{
        if (index >= 0 && index < habits.count){
            return habits[index]
        }
        return nil
    }
    
    func bestStreaks() -> [Habit]{
        let sortedHabitList = habits.sorted(by: {$1.streak > $0.streak} )
        let prefixedList = Array(sortedHabitList.prefix(3))
        return prefixedList
    }
    
    
    
}
