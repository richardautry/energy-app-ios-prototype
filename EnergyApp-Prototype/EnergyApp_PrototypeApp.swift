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
            // scheduleAppRefresh()
            print("THIS IS THE BACKGROUND TASK FIRING")
            // TODO: Add turn_off function here
            // TODO: How to pass my device instance and call its function here
        }
    }
    
//    init() {
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "TurnOffDevice", using: nil, launchHandler: {task in
//            print("THIS IS A BACKGROUND TASK SCHEDULER FIRIING")
//        })
//    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let feedVC = (window?.rootViewController as? UINavigationController)?.viewControllers.first as? FeedTableViewController
//        feedVC?.server = server
//
//        PersistentContainer.shared.loadInitialData()
//
//        // MARK: Registering Launch Handlers for Tasks
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.apple-samplecode.ColorFeed.refresh", using: nil) { task in
//            // Downcast the parameter to an app refresh task as this identifier is used for a refresh request.
//            self.handleAppRefresh(task: task as! BGAppRefreshTask)
//        }
//
//        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.apple-samplecode.ColorFeed.db_cleaning", using: nil) { task in
//            // Downcast the parameter to a processing task as this identifier is used for a processing request.
//            self.handleDatabaseCleaning(task: task as! BGProcessingTask)
//        }
//
//        return true
//    }
}

func scheduleAppRefresh() {
    let today = Calendar.current.startOfDay(for: .now)
    let nextDate = Calendar.current.date(byAdding: .second, value: 1, to: today)
//    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
//    let noonComponent = DateComponents(hour: 12)
//    let noon = Calendar.current.date(byAdding: noonComponent, to: tomorrow)
    
    let request = BGAppRefreshTaskRequest(identifier: "TurnOffDevice")
    request.earliestBeginDate = nextDate
    try? BGTaskScheduler.shared.submit(request)
    print("BGTASK SCHEDULED")
}
