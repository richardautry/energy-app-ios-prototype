//
//  FullDeviceAutomationsView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/27/23.
//

import SwiftUI

struct FullDeviceAutomationsView: View {
    @State private var someText: String = "BEFORE"
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
        test_sleep(5000)
        someText = "AFTER"
    }
}

struct FullDeviceAutomationsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceAutomationsView()
    }
}
