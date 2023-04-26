//
//  ViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var toListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        let theDate = Date()
        let dateString = dateFormatter.string(from: theDate)
        print(dateString)
        print(yesterday(day:dateString))
        
        
        // Do any additional setup after loading the view.
    }
    
    func yesterday(day: String) -> String{
        let yearInt = Int(day.prefix(4)) ?? 11
        let monthInt = Int(day.suffix(5).prefix(2)) ?? 11
        let dayInt = Int(day.suffix(2)) ?? 11
        
        
        //handle going back a day
        
        
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

