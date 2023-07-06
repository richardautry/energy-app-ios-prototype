//
//  ContentView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/6/23.
//

import SwiftUI

struct ContentView: View {
    // TODO: Get and display current battery level
    // UIDevice.current.isBatteryMonitoringEnabled = true
    // let level = UIDevice.current.batteryLevel
    let level = UIDevice.current.batteryLevel
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("\(level)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
