//
//  PillTableViewController.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import UIKit

class PillListTableViewController: UITableViewController {
    
    var pillController = PillController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillController.pills.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "PillCell", for: indexPath) as? PillsTableViewCell else { return UITableViewCell() }
        
        cell.pill = pillController.pills[indexPath.row]
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // guard let pillController = pillController else {return}
        if segue.identifier == "AddPillShowSegue2" {
            guard let addPillVC = segue.destination as? AddPillViewController else {return}
            addPillVC.pillController = self.pillController
        } else if segue.identifier == "EditPillShowSegue" {
        if let indexPath = tableView.indexPathForSelectedRow,
            let pillVC = segue.destination as? AddPillViewController {
            pillVC.pill = pillController.pills[indexPath.row]
            }
        }
    }
}
