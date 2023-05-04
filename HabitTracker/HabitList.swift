//
//  HabitList.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-25.
//

import Foundation
import Firebase

class HabitList{
    private var habits = [Habit]()
    let db = Firestore.firestore()
    let auth = Auth.auth()
    
    init(){
        add(habit: Habit(name: "Read a book"))
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
        let prefixedList = Array(sortedHabitList.suffix(3))
        return prefixedList
    }
    
    //writes all habits in the list to firestore (this probably shouldn't be used)
    func writeToFirestore(){
        guard let user = auth.currentUser else {return}
        let habitsRef = db.collection("users").document(user.uid).collection("habits")
        
        for habit in habits{
            do{
                try habitsRef.addDocument(from: habit)
            } catch{
                print("Error sending to Database")
            }
        }
    }
    
    //add snapshot listener to download habit list from firestore
    func listenToFirestore() {
        guard let user = auth.currentUser else {return}
        let habitsRef = db.collection("users").document(user.uid).collection("habits")
        
        habitsRef.addSnapshotListener() {
            snapshot, err in
            
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                self.habits.removeAll()
                for document in snapshot.documents{
                    do {
                        let habit = try document.data(as : Habit.self)
                        self.habits.append(habit)
                    } catch {
                        print("Error reading from Database")
                    }
                }
            }
            
        }
    }
    
    
    
}
