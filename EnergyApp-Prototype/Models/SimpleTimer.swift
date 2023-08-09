//
//  Timer.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 8/7/23.
//

import Foundation

// TODO: Create a timer class that will track time independent of views and can be pollable in multiple places
// i.e. need sto be a background task
class SimpleTimer: ObservableObject {
    @Published var numHours: Double = 0
    @Published var numMinutes: Double = 0
    @Published var totalSecs: Int = 1
    @Published var progressSecs: Int = 0
    @Published var minutesRemaining: Int = 0
    
    func sleepAsync() async -> Void {
        // TODO: Use Timer here properly as in Scrum example
        DispatchQueue.main.async {
            self.progressSecs = 0
            self.totalSecs = Int(self.hoursToSecs(hours: self.numHours)) + Int(self.minutesToSecs(minutes: self.numMinutes))
        }
        let startDate = Date()
        while progressSecs <= totalSecs {
            sleep(1)
            DispatchQueue.main.async {
                self.progressSecs = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            }
            DispatchQueue.main.async {
                self.minutesRemaining = ((self.totalSecs - self.progressSecs) / 60) + 1
            }
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
