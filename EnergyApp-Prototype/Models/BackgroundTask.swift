//
//  BackgroundTask.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 8/9/23.
//

import Foundation
import BackgroundTasks

class TurnOffBackgroundTaskRequest: BGAppRefreshTaskRequest {
    override init(identifier: String) {
        // TODO: Add args to get device and turn off here
        super.init(identifier: identifier)
    }
}
