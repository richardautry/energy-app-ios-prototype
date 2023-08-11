//
//  EnergyApp_PrototypeApp.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/6/23.
//

import SwiftUI
import BackgroundTasks

@main
struct EnergyApp_PrototypeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .backgroundTask(.appRefresh("TurnOffDevice")) {
            //scheduleAppRefresh()
            // TODO: Add turn_off function here
            // TODO: How to pass my device instance and call its function here
        }
    }
        
}

func scheduleAppRefresh() {
    let today = Calendar.current.startOfDay(for: .now)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    let noonComponent = DateComponents(hour: 12)
    let noon = Calendar.current.date(byAdding: noonComponent, to: tomorrow)
    
    let request = BGAppRefreshTaskRequest(identifier: "TurnOffDevice")
    request.earliestBeginDate = noon
    try? BGTaskScheduler.shared.submit(request)
}
