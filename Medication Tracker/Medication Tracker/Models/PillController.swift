//
//  PillModelController.swift
//  Medication Tracker
//
//  Created by patelpra on 12/18/19.
//  Copyright © 2019 Crus Technologies. All rights reserved.
//

import Foundation

class PillController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var pills: [Pill] = []
    
    var prescriptionPills: [Pill] {
        let filter = pills
            .filter { $0.isPrescription }
            .sorted { $0.name < $1.name }
        return filter
    }
    
    // Set up an alphabetical array of all the supplement pills.
    var supplementPills: [Pill] {
        let filter = pills
            .filter { !$0.isPrescription }
            .sorted { $0.name < $1.name }
        return filter
    }
    
    private var pillListFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory.appendingPathComponent("PillList.plist")
    }
    
    // MARK: - CRUD
    func createPill(addPill: Pill) {
        pills.append(pill)
        saveToPersistentStore
    }
    
    func deletePill(removePill: Pill) {
        guard let index = pills.firstIndex(of: pill)
            else { return }
        pills.remove(at: index)
        saveToPersistentStore
    }
    
    func updatePill(forPill: Pill, withName: String?, forCondition: String?, dosageFrequency: Frequency) {
        // NEED TO COMPLETE
    }

    
    
    
    // MARK: - Save to disk
    func saveToPersistentStore() {
        guard let url = self.pillListFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let pillsData = try encoder.encode(pills)
            try pillsData.write(to: url)
        } catch {
            NSLog("Error saving pills data: \(error)")
        }
    }
    
    // MARK: - Load from disk
    func loadFromPersistentStore() {
        guard let url = pillListFileURL else { return }
                
        do {
            let pillsData = try Data(contentsOf: url)
            let decodedPills = PropertyListDecoder()
            self.pills = try decodedPills.decode([Pill].self, from: pillsData)
        } catch {
            NSLog("Error loading pills data: \(error)")
        }
    }
}
