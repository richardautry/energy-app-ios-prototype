//
//  FullDeviceAutomationsView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/27/23.
//

import SwiftUI
import Combine

struct FullDeviceAutomationsView: View {
    @Binding var fullDevice: FullDevice
    @Binding var isOn: Bool
    @State private var hours: String = "0"
    @State private var numHours: Double = 0
    @State private var numMinutes: Double = 0
    @State private var totalSecs: Int = 1
    @State private var progressSecs: Int = 0
    @State private var timer: Timer = Timer()
    @State private var minutesRemaining: Int = 0
    var body: some View {
        List {
            Text("Full Device Automations")
            HStack {
                Label("Turn Off After", systemImage: "clock")
                Spacer()
                Button(action: {
                    Task {
                        await sleepAsync()
                    }
                }) {
                    Text("Test")
                }
            }
            HStack {
                Label("", systemImage: "clock")
                Spacer()
                Slider(value: $numHours, in: 0...12, step: 1) {
                    Text("Length")
                }
                Text("\(Int(numHours)) hr(s)")
                    .accessibilityHidden(true)
            }
            HStack {
                Label("", systemImage: "clock")
                Spacer()
                Slider(value: $numMinutes, in: 0...60, step: 1) {
                    Text("Length")
                }
                Text("\(Int(numMinutes)) min(s)")
                    .accessibilityHidden(true)
            }
            Text("\(minutesRemaining) minutes remaining")
            Section {
                ProgressView(value: Double(progressSecs) / Double(totalSecs))
            }
        }
        .padding()
    }
    
    // TODO: Make this an automation that always tracks in background and isn't
    // tied to a view
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

struct FullDeviceAutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceAutomationsView(fullDevice: .constant(FullDeviceMock.sampleData[0]), isOn: .constant(false))
    }
}
