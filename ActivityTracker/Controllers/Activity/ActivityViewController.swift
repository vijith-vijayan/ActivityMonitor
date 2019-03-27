//
//  ViewController.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit
import CoreLocation
import HealthKit

class ActivityViewController: UIViewController {
    
    private var instantPace: Double = 0.0
    private var seconds: Double = 0.0
    private var distance: Double = 0.0
    
    private let manager = Locations.locationManager
    private let activity = Activity()
    
    lazy var location: [CLLocation] = []
    lazy var timer = Timer()
    
    lazy var activityViewModel: ActivityViewModel = {
        return ActivityViewModel()
    }()

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.delegate = self
        activityViewModel.motionDelegate = self
        activityViewModel.startMonitoring()
        manager.requestWhenInUseAuthorization()
    }

    public func startWalking() {
        walking()
        location.removeAll(keepingCapacity: false)
        manager.startUpdatingLocation()
    }
    
    @objc private func walking() {
        
        seconds += 1
        let distanceCovered = HKQuantity(unit: HKUnit.meter(), doubleValue: distance)
        let paceUnit = HKUnit.second().unitDivided(by: HKUnit.meter())
        let liveSpeed = HKQuantity(unit: paceUnit, doubleValue: seconds / distance)
        print("Distance : \(distance)")
        print("Seconds: \(seconds)")
        print(liveSpeed.description)
        print(distanceCovered.description)
        DispatchQueue.main.async {
            self.speedLabel.text = liveSpeed.description
            self.distanceLabel.text = distanceCovered.description
        }
        
    }
    
    private func stopWalking() {
        stopTimer()
        seconds = 0.0
        distance = 0.0
    }
    
    private func stopTimer() {
        manager.stopUpdatingLocation()
    }
    
    /// Save Walking Data
    private func saveWalk() {
        
        activity.averageSpeed = self.instantPace
        activity.distance = self.distance
        
        if activity.save() {
            print("Saved Successfully")
        } else {
            print("Could not save the walk")
        }
    }

}

extension ActivityViewController: CLLocationManagerDelegate {
    
    /// Location manager did update location
    ///
    /// - Parameters:
    ///   - manager: Location manager passed from
    ///   - locations: Array of location retrieves
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
                //update distance
                if self.location.count > 0 {
                    distance += location.distance(from: self.location.last!)
                    var coords = [CLLocationCoordinate2D]()
                    coords.append(self.location.last!.coordinate)
                    coords.append(location.coordinate)
                    
                    instantPace = location.distance(from: self.location.last!)/(location.timestamp.timeIntervalSince(self.location.last!.timestamp))
                }
                //save location
                self.location.append(location)
            }
        }
}

extension ActivityViewController: MotionDetect {
    
    func walkingEnd() {
        stopWalking()
    }
    
    func walkingBegan() {
        startWalking()
    }
    
    
}
