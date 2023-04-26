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
        print(yesterday(day: "2023/03/01"))
        print(yesterday(day: "2023/03/01"))
        print(yesterday(day: "2021/02/02"))
        print(yesterday(day: "2017/01/01"))
        print(yesterday(day: "2023/06/30"))
        print(yesterday(day: "2023/08/01"))
        
        
        // Do any additional setup after loading the view.
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
        
        //----
        
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

