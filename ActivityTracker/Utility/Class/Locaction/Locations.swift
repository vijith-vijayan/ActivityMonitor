//
//  Locations.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import CoreLocation

class Locations {
    
    static var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
        manager.distanceFilter = 10.0
        return manager
    }()
    
}
