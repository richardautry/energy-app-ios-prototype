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
    @Binding var simpleTimer: SimpleTimer
    
    // TODO: Wire up simple timer and hour/min values correctly
    
    var body: some View {
        List {
            Text("Full Device Automations")
            HStack {
                Label("Turn Off After", systemImage: "clock")
                Spacer()
                Button(action: {
                    Task {
                        await simpleTimer.sleepAsync()
                    }
                }) {
                    Text("Test")
                }
            }
            HStack {
                Label("", systemImage: "clock")
                Spacer()
                Slider(value: $simpleTimer.numHours, in: 0...12, step: 1) {
                    Text("Length")
                }
                Text("\(Int(simpleTimer.numHours)) hr(s)")
                    .accessibilityHidden(true)
            }
            HStack {
                Label("", systemImage: "clock")
                Spacer()
                Slider(value: $simpleTimer.numMinutes, in: 0...60, step: 1) {
                    Text("Length")
                }
                Text("\(Int(simpleTimer.numMinutes)) min(s)")
                    .accessibilityHidden(true)
            }
            Text("\(simpleTimer.minutesRemaining) minutes remaining")
            Section {
                ProgressView(value: Double(simpleTimer.progressSecs) / Double(simpleTimer.totalSecs))
            }
        }
        .padding()
    }
    
    // TODO: Make this an automation that always tracks in background and isn't
    // tied to a view
}
struct FullDeviceAutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceAutomationsView(
            fullDevice: .constant(FullDeviceMock.sampleData[0]),
            isOn: .constant(false),
            simpleTimer: .constant(SimpleTimer.sampleData[0])
        )
    }
}
