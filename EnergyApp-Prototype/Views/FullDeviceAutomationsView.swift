//
//  FullDeviceAutomationsView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/27/23.
//

import SwiftUI
import Combine

struct FullDeviceAutomationsView: View {
    @State private var someText: String = "BEFORE"
    @Binding var fullDevice: FullDevice
    @Binding var isOn: Bool
    @State private var hours: String = "0"
    @State private var numHours: Int32 = 0
    @State private var progressMS: Int32 = 0
    var body: some View {
        List {
            Text("Full Device Automations")
            HStack {
                Label("Turn Off After", systemImage: "clock")
                Spacer()
                Button(action: {
                    Task {
                        // TODO: Will need to be able to query Rust state for current timer progress for better accuracy here
                        progressMS = hoursToMs()
                        await sleepAsync(lengthMs: progressMS)
                    }
                }) {
                    Text("Test")
                }
            }
            HStack {
                Label("Hours", systemImage: "clock")
                Spacer()
                TextField("Hour(s)", text: $hours)
                    .keyboardType(.numberPad)
                    .onReceive(Just(hours)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue && newValue.count < 3 {
                            self.hours = filtered
                        }
                    }
                    .fixedSize()
            }
            Text(someText)
            Section {
                ProgressView(value: Double(progressMS))
            }
        }
        .padding()
    }
    
    func sleepAsync(lengthMs: Int32) async -> Void {
        // TODO: Add binding to FullDevice to update value after automation runs
        fullDevice.turnOffAfter(length_ms: lengthMs)
        isOn = fullDevice.is_on
        someText = "AFTER"
    }
    
    func hoursToMs() -> Int32 {
        let numHours = Int32(hours)!
        return numHours * 60 * 60 * 1000
    }
}

struct FullDeviceAutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceAutomationsView(fullDevice: .constant(FullDeviceMock.sampleData[0]), isOn: .constant(false))
    }
}
