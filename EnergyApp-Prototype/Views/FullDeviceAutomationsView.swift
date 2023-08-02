//
//  FullDeviceAutomationsView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/27/23.
//

import SwiftUI

struct FullDeviceAutomationsView: View {
    @State private var someText: String = "BEFORE"
    @Binding var fullDevice: FullDevice
    @Binding var isOn: Bool
    var body: some View {
        VStack(alignment: .leading) {
            Text("Full Device Automations")
            Spacer()
            HStack {
                Label("Timer", systemImage: "clock")
                Spacer()
                Button(action: {
                    Task {
                        await sleepAsync()
                    }
                }) {
                    Text("Start")
                }
            }
            Text(someText)
        }
        .padding()
    }
    
    func sleepAsync() async -> Void {
        // TODO: Add binding to FullDevice to update value after automation runs
        fullDevice.turnOffAfter(length_ms: 5000)
        isOn = fullDevice.is_on
        someText = "AFTER"
    }
}

struct FullDeviceAutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceAutomationsView(fullDevice: .constant(FullDeviceMock.sampleData[0]), isOn: .constant(false))
    }
}
