//
//  ActivityHistoryCellModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 28/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import Foundation

class HistoryCellViewModel {
    
    /// Variables
    let avgSpeed: Double
    let distance: Double
    
    /// Activity History initializer
    ///
    /// - Parameters:
    ///   - avgSpeed: Average speed of the walk
    ///   - distance: Total distance covered in the walk
    init(avgSpeed: Double, distance: Double) {
        
        self.avgSpeed = avgSpeed
        self.distance = distance
    }
    
}
