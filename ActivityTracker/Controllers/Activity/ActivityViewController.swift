//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit
import CoreLocation

class ActivityViewController: UIViewController {
    
    private var walkingBegan: Bool
    private var instantPace: Double
    private var seconds: Double
    private var distance: Double
    private var instantPace: Double
    
    private let manager = Locations.locationManager
    private let activity = Activity()
    
    lazy var location: [CLLocation] = []
    lazy var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }

    public mutating func startWalking() {
        
        if !walkingBegan {
            walkingBegan = true
            distance = 0.0
            seconds = 0
            location.removeAll(keepingCapacity: false)
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(self.walking),
                                         userInfo: nil,
                                         repeats: true)
        } else {
            walkingBegan = false
            stopWalking()
            
        }
    }
    
    private mutating func walking() {
        seconds += 1
        let distanceCovered = HKQuantity(unit: HKUnit.mile(), doubleValue: distance)
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.mile())
        let liveSpeed = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
    }
    
    private mutating func stopWalking() {
        stopTimer()
    }
    
    private mutating func stopTimer()  {
        self.timer.invalidate()
    }
    
    private func saveWalk() {
        
        activity.averageSpeed = self.instantPace
        activity.distance = self.distance
        activity.save()
        
    }

}

