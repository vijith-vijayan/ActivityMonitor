//
//  ActivityFormatter.swift
//  ActivityTracker
//
//  Created by Vijith TV on 29/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import Foundation

struct ActivityFormater {
    
    /// Distance
    ///
    /// - Parameter distance: Distance of the walk
    /// - Returns: Distance in string
    static func distance(_ distance: Double) -> String {
        let distanceMeasurement = Measurement(value: distance, unit: UnitLength.meters)
        return ActivityFormater.distance(distanceMeasurement)
    }
    
    /// Distance from length
    ///
    /// - Parameter distance: Distance measurement in unit leghth
    /// - Returns: String format of distance
    static func distance(_ distance: Measurement<UnitLength>) -> String {
        let formatter = MeasurementFormatter()
        return formatter.string(from: distance)
    }
    
    /// Time
    ///
    /// - Parameter seconds: Seconds in Integer
    /// - Returns: String of time
    static func time(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds))!
    }
    
    /// Pace of the walk
    ///
    /// - Parameters:
    ///   - distance: Distance measurment
    ///   - seconds: Time measuremnet in seconds
    ///   - outputUnit: Speed in unitspeed
    /// - Returns: String of pace of walk
    static func pace(distance: Measurement<UnitLength>, seconds: Int, outputUnit: UnitSpeed) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit] // 1
        let speedMagnitude = seconds != 0 ? distance.value / Double(seconds) : 0
        let speed = Measurement(value: speedMagnitude, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: speed.converted(to: outputUnit))
    }
    
    /// Date of walk
    ///
    /// - Parameter timestamp: Unix timestamp
    /// - Returns: String from date
    static func date(_ timestamp: Date?) -> String {
        guard let timestamp = timestamp as Date? else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: timestamp)
    }
}
