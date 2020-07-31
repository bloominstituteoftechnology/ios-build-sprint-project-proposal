//
//  NoteTableViewCell.swift
//  QuickScript
//
//  Created by Dahna on 7/31/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    var note: Note? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    
    private func updateViews() {
        guard let note = note else { return }
        
        titleLabel.text = note.title.capitalized
        dateLabel.text = note.date.stringDate()
        
        switch note.category {
        case .none:
            categoryImageView.image = UIImage(named: "none")
        case .personal:
            categoryImageView.image = UIImage(named: "personal")
        case .school:
            categoryImageView.image = UIImage(named: "school")
        case .work:
            categoryImageView.image = UIImage(named: "work")
        }
        
    }
    
}
