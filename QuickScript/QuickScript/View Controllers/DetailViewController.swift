//
//  DetailViewController.swift
//  QuickScript
//
//  Created by Dahna on 7/27/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var noteController: NoteController?
    var note: Note?

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categorySegControl: UISegmentedControl!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    @IBAction func exportButtonTapped(_ sender: Any) {
        
        guard let note = note else { return }
        
        let activityController = UIActivityViewController(activityItems: [note.title, note.date, note.body] as [Any], applicationActivities: nil)
        
        present(activityController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        guard let note = note else { return }
        
        self.title = note.title.capitalized
        noteTextView.text = note.body

        let chosenCat = note.category
        
        categorySegControl.selectedSegmentIndex = Category.allCases.firstIndex(of: Category(rawValue: chosenCat.rawValue)!) ?? 1
    }

}
