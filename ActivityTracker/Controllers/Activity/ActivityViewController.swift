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
    private var seconds: Int = 0
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    
    private let manager = Locations.locationManager
    private let activity = Activity()
    
    lazy var locationList: [CLLocation] = []
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
    
    /// View Did Load
    ///
    /// - Parameter animated: Bool value with animation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        timer.invalidate()
    }

    /// Start walking
    public func startWalking() {
        locationList.removeAll(keepingCapacity: false)
        walking()
    }
    
    /// Walking
    @objc private func walking() {
        
        seconds = 0
        distance = Measurement(value: 0, unit: .meters)
        updateUI()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        manager.startUpdatingLocation()
    }
    
    /// Update UI
    func updateUI()  {
        
        let distance = ActivityFormater.distance(self.distance)
        //let time = ActivityFormater.time(Int(seconds))
        let pace = ActivityFormater.pace(distance: self.distance,
                                         seconds: self.seconds,
                                         outputUnit: UnitSpeed.minutesPerMile)
        distanceLabel.text = "Distance: \(distance)"
        speedLabel.text = "Speed: \(pace)"
    }
    
    /// Timer seconds
    func eachSecond() {
        seconds += 1
        updateUI()
    }
    
    /// Stop walking
    private func stopWalking() {
        timer.invalidate()
        stopLocationUpdate()
        saveWalk()
    }
    
    /// Stop upadting location
    private func stopLocationUpdate() {
        manager.stopUpdatingLocation()
    }
    
    /// Save Walking Data
    private func saveWalk() {
        
        activity.averageSpeed = (self.distance.value/Double(seconds))
        activity.distance = self.distance.value
        activity.duration = self.seconds
        activity.timestamp = Date()
        if activity.save() {
            print("Saved Successfully")
        } else {
            print("Could not save the walk")
        }
    }
    
    /// Start Monitor walking button action
    ///
    /// - Parameter sender: Instance of any type, that can be a class or reference type
    @IBAction func startAction(_ sender: Any) {
        //activityViewModel.startMonitoring()
        startWalking()
    }
    
    /// Stop monitor walking
    ///
    /// - Parameter sender: Instance of any type, that can be a class or reference type
    @IBAction func stopAction(_ sender: Any) {
        //activityViewModel.stopMonitoring()
        stopWalking()
    }
    
    
    /// Unwind segue
    ///
    /// - Parameter segue: Storyboard Segue
    @IBAction func unwindToActivityView(_ segue: UIStoryboardSegue) {
        
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
        
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            locationList.append(newLocation)
        }
    }
}
