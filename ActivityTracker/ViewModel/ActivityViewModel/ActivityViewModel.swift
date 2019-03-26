//
//  ActivityViewModel.swift
//  ActivityTracker
//
//  Created by Vijith TV on 26/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import Foundation

public struct ActivityViewModel {
    
    private let activity: Activity
    
    
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
}
