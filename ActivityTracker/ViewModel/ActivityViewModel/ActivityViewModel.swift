//
//  ActivityViewModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import RealmSwift
import CoreMotion

protocol MotionDetect {
    func walkingBegan()
    func walkingEnd()
}

public class ActivityViewModel {
    
    private let activity = Activity()
    private var motionActivityManager: CMMotionActivityManager!
    private var timer = Timer()
    
    var motionDelegate: MotionDetect?
    
    
    
   
    /// Fetch Walking data from Realm DB
    ///
    /// - Returns: Array of walking data
    func processWalkData<T>() -> [T] {
        let realm = try! Realm()
        let walkData = realm.objects(Activity.self).arrayValue(ofType: T.self) as [T]
        return walkData
    }
    
    func startMonitoring() {
        
        detectMotion()
    }
    
    @objc func detectMotion()  {
        
        var isWalking: Bool = false
        var isStationary: Bool = false
        motionActivityManager = CMMotionActivityManager()
        motionActivityManager.startActivityUpdates(to: OperationQueue.main) { (activity) in
            isWalking = activity?.walking ?? false
            isStationary = activity?.stationary ?? false
            if isWalking {
                self.motionDelegate?.walkingBegan()
            } else if isStationary {
                self.motionDelegate?.walkingEnd()
            }
        }
    }
}
