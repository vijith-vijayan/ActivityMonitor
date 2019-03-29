//
//  ActivityViewModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import RealmSwift

public class ActivityViewModel {
    
    private let activity = Activity()
   
    /// Fetch Walking data from Realm DB
    ///
    /// - Returns: Array of walking data
    func processWalkData<T>() -> [T] {
        let realm = try! Realm()
        let walkData = realm.objects(Activity.self).arrayValue(ofType: T.self) as [T]
        return walkData
    }
}
