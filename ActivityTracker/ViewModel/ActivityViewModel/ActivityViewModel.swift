//
//  ActivityViewModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import Foundation
import CoreLocation
import HealthKit

public struct ActivityViewModel {
    
    private let activity: Activity
    private var walkingBegan: Bool
    private var instantPace: Double
    private var seconds: Int
    
    lazy var location: [CLLocation] = []
    lazy var timer = Timer()
    
    /// Initializer
    ///
    /// - Parameter activity: Activity of the user
    public init(activity: Activity){
        self.activity = activity
    }
    
    /// Distance
    public var distance: Double {
        return activity.distance
    }
    
    /// Average speed
    public var averageSpeed: Double {
        return activity.averageSpeed
    }
    
    /// Steps
    public var steps: Int {
        return activity.steps
    }
    
    public mutating func startWalking() {
        
        if !walkingBegan {
            walkingBegan = true
            activity.distance = 0.0
            seconds = 0
            location.removeAll(keepingCapacity: false)
        }
    }
    
    private mutating func walking() {
        seconds += 1
        
        let distanceCovered = HKQuantity(unit: HKUnit.mile(), doubleValue: activity.distance)
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.mile())
        let liveSpeed = HKQuantity(unit: paceUnit, doubleValue: Double(seconds) / activity.distance)
        activity.averageSpeed = liveSpeed
    }
    
    private mutating func stopWalking() {
        
    }
    
    private mutating func stopTimer()  {
        
        self.timer.invalidate()
    }
}
