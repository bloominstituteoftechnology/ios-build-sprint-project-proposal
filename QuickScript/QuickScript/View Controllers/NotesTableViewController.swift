//
//  NotesTableViewController.swift
//  QuickScript
//
//  Created by Dahna on 7/31/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
    
    let noteController = NoteController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return noteController.notes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
            fatalError("Could not make note cell")
        }
       
        let note = noteController.notes[indexPath.row]
        
//        cell.textLabel?.text = note.title
//        cell.detailTextLabel?.text = note.date.stringDate()
        cell.note = note

        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreateNoteSegue" {
            guard let createVC = segue.destination as? CreateViewController else { return }
            createVC.noteController = noteController
        }
        
        if segue.identifier == "ShowDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.noteController = noteController
            detailVC.note = noteController.notes[indexPath.row]
        }
    }
}
