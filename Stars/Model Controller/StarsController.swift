//
//  StarsController.swift
//  Stars
//
//  Created by Hannah Bain on 4/23/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class StarsController {
    init() {
        self.loadFromPersistentStore()
        
    }
    // data set - one source of truth
    private(set) var stars: [Star] = []
    
    
    // CRUD functions
    //create
    
   @discardableResult func createStar(name: String, distance: Double) -> Star {
        let star = Star(name: name, distance: distance)
        stars.append(star)
    self.saveToPersistentStore()
        return star
    }
    
   
    
    // MARK -Persistence
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        
        // we want to access the documents directory in user's domain
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        // create a new plish file in directory
        return directory.appendingPathComponent("stars.plist")
    }
    
    // save
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
        NSLog("Error saving stars data: \(error)")
    }
        
        
    
    }
    // load
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL,
            fm.fileExists(atPath: url.path) else { return }
        
        //plist file -> date -> stars
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            stars = try decoder.decode([Star].self, from: data)
        } catch {
            NSLog("Error loading stars data: \(error)")
            
        }
        
    }
    
    
}
