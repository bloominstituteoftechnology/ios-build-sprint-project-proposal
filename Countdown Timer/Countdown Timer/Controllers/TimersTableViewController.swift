//
//  TimersTableViewController.swift
//  Countdown Timer
//
//  Created by Mark Gerrior on 3/2/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import UIKit

extension Date {

    func offsetFrom(date: Date, type: TimerType) -> String {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        var seconds = ""
        var minutes = ""
        var hours = ""
        var days = ""
        var typeStr = ""

        switch type {
        case .both:
            typeStr = " 📆⏰"
            seconds = "\(difference.second ?? 0)s"
            minutes = "\(difference.minute ?? 0)m" + " " + seconds
            hours = "\(difference.hour ?? 0)h" + " " + minutes
            days = "\(difference.day ?? 0)d" + " " + hours
        case .date:
            typeStr = " 📆"
            days = "\(difference.day ?? 0) Days"
        case .time:
            typeStr = " ⏰"
            seconds = "\(difference.second ?? 0)s"
            minutes = "\(difference.minute ?? 0)m" + " " + seconds
            hours = "\(difference.hour ?? 0)h" + " " + minutes
            days = "\(difference.day ?? 0)d" + " " + hours
        }

        if let day = difference.day, day          > 0 { return days + typeStr }
        if let hour = difference.hour, hour       > 0 { return hours + typeStr }
        if let minute = difference.minute, minute > 0 { return minutes + typeStr }
        if let second = difference.second, second > 0 { return seconds + typeStr }
        return "Done"
    }

}

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
        startTimer()

        if false {
            notificationButton.isEnabled = false            
        } else {
            notificationButton.isEnabled = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cancelTimer()
    }

    // MARK: - Timer related code

    // called each time the timer object fires
    var systemCountdownTimer: Timer?
    var timerIterations = 0

    private func startTimer() {
        print("Start timer")
        if systemCountdownTimer == nil {
            systemCountdownTimer = Timer.scheduledTimer(withTimeInterval: 0.50, repeats: true, block: timerFired(timer:))
        }
    }
    
    private func cancelTimer() {
        print("Cancel timer")
        // We must invalidate a timer, or it will continue to run even if we
        // start a new timer
        systemCountdownTimer?.invalidate()
        systemCountdownTimer = nil
    }

    private func timerFired(timer: Timer) {
        timerIterations += 1
        print("Timer Fired \(timerIterations)")
        updateTableViewTimer()
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

    func updateTableViewTimer() {
        // TODO: Very unhappy with this. What if I have more than a screenful of data?
        var row = 0
        for timer in timeController.timers {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! TimerTableViewCell
            
            var displayTimer = "N/A"
            if let dateTime = timer.dateTime {
                displayTimer = dateTime.offsetFrom(date: Date(), type: timer.timerType)
            }
            cell.timerLabel.text = displayTimer
            row += 1
        }
    }

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
        startTimer()
    }
}
