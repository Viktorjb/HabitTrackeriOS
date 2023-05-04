//
//  TableViewController.swift
//  HabitTracker
//
//  Created by Viktor on 2023-04-24.
//

import UIKit

class TableViewController: UITableViewController {
    
    var habits : HabitList?

    let showSingleHabitSegue = "showSingleHabit"
    let addHabitSegue = "addHabitSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return habits?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath)

        //sort the habits by ID like firebase does
        habits?.sortByID()
        let habitName = habits?.getHabit(index: indexPath.row)
        cell.textLabel?.text = (habitName?.name ?? "nil").prefix(18) + "       Streak: " + String(habitName?.streak ?? 0)
        
        //Check if it's been done today, and colour the cell
        let hasBeenDone = habitName?.hasBeenDoneToday() ?? false
        if(hasBeenDone){
            cell.contentView.backgroundColor = UIColor(red: 18/256, green: 178/256, blue: 29/256, alpha: 0.65)
        } else{
            cell.contentView.backgroundColor = UIColor(red: 200/256, green: 18/256, blue: 29/256, alpha: 0.65)
        }
            
        // Configure the cell...

        return cell
    }
    
    //function for the firestore snapshot listener to access
    func reloadTableView(){
        tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == addHabitSegue){
            let vc = segue.destination as! AddHabitViewController
            vc.habits = habits
        } else if(segue.identifier == showSingleHabitSegue){
            guard let vc = segue.destination as? ShowSingleHabitViewController else {return}
            
            guard let cell = sender as? UITableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: cell) else {return}
            guard let habit = habits?.getHabit(index: indexPath.row) else {return}
            
            
            vc.habit = habit
        }
        
    }
    

}
