//
//  Activity.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import RealmSwift

public class Activity: Object {
    
    /// Public variables
    @objc dynamic var distance: Double = 0.0
    @objc dynamic var steps: Int = 0
    @objc dynamic var averageSpeed: Double = 0.0
    
    /// Save Data
    ///
    /// - Returns: Data saving statis
    func save() -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
            return true
        } catch let error as NSError {
            print(">>> Realm Error: ", error.localizedDescription)
            return false
        }
    }
}
