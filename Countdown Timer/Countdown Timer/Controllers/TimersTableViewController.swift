//
//  TimersTableViewController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

class TimersTableViewController: UITableViewController /* TODO: UITableViewDataSource baked in? */  {

    var timeController = TimerController()
    var notificationController = NotificationController()
    
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    
    @IBAction func notificationButtonPress(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func filterButton(_ sender: Any) {
        // Grab a list of all the filter types.
        // Create alert actions for each type
        // Present alert to uesr to select type.
        // Filter on type. 
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Count🔻",
            message: "Notifications have been turned off. Please turn them on in settings.",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if false {
            notificationButton.isEnabled = false            
        } else {
            notificationButton.isEnabled = true
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = timeController.activeTimers.count
        return result
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimerCell", for: indexPath) as? TimerTableViewCell else { fatalError("TimerTableViewCell was expected" ) }

        // Configure the cell
        cell.timer = timeController.timers[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let timerToBeDeleted = timeController.timers[indexPath.row]
            timeController.delete(timer: timerToBeDeleted)

            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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

        guard let detailVC = segue.destination as? DetailViewController else {return}
        detailVC.timerModelDelegate = timeController
        
        if segue.identifier == "AddDetailSegue" {
            print("AddDetailSegue called")
        } else if segue.identifier == "EditDetailSegue" {
            print("EditDetailSegue called")
            // Find the timer the user tapped on and set the VC's timer object to it.
            guard let indexPath = tableView?.indexPathForSelectedRow else { return }
            let timer = timeController.timers[indexPath.row]
            detailVC.timer = timer
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
