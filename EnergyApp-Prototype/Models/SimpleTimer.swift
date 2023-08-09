//
//  Timer.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 8/7/23.
//

import Foundation

// TODO: Create a timer class that will track time independent of views and can be pollable in multiple places
// i.e. need sto be a background task
class SimpleTimer {
    @Published var numHours: Double = 0
    @Published var numMinutes: Double = 0
    @Published var totalSecs: Int = 1
    @Published var progressSecs: Int = 0
    @Published var minutesRemaining: Int = 0
    
    func sleepAsync() async -> Void {
        // TODO: Use Timer here properly as in Scrum example
        progressSecs = 0
        totalSecs = Int(hoursToSecs(hours: numHours)) + Int(minutesToSecs(minutes: numMinutes))
        let startDate = Date()
        while progressSecs <= totalSecs {
            sleep(1)
            progressSecs = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            minutesRemaining = (totalSecs - progressSecs) / 60
        }
    }
    
    func hoursToSecs(hours: Double) -> Double {
        return hours * 60 * 60
    }
    
    func minutesToSecs(minutes: Double) -> Double {
        return minutes * 60
    }
}

extension SimpleTimer {
    static let sampleData: [SimpleTimer] =
    [
        SimpleTimer()
    ]
}
