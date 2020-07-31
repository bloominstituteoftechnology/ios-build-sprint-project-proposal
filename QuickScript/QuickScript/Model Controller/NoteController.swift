//
//  NoteController.swift
//  QuickScript
//
//  Created by Dahna on 7/31/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

class NoteController {
    
    var notes: [Note] = []

    init() {
        loadFromPersistentStore()
    }

    func createNote(title: String, category: String, body: String) {
        
        let note = Note(title: title, date: Date(), category: Category(rawValue: category) ?? Category.none, body: body)
        
        notes.append(note)
        
        saveToPersistentStore()
    }
    
    // MARK: - Persistence

    var persistentFileURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                
        let notesURL = documentsDir?.appendingPathComponent("notes.plist")
        
        return notesURL
    }
    
    func saveToPersistentStore() {
        
        do {

            let encoder = PropertyListEncoder()

            let notesPlist = try encoder.encode(notes)
            
            guard let persistentFileURL = persistentFileURL else { return }
            
            try notesPlist.write(to: persistentFileURL)
            print("written to save")
        } catch {

            NSLog("Error saving notes: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let persistentFileURL = persistentFileURL else { return }
        
        do {
            let decoder = PropertyListDecoder()
            
            let notesPlist = try Data(contentsOf: persistentFileURL)
            
            let notes = try decoder.decode([Note].self, from: notesPlist)
            
            self.notes = notes
            
            print("loaded from store")
            
        } catch {
            NSLog("Error decoding notes to load: \(error)")
        }
    }
}

