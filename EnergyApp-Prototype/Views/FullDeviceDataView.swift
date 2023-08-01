//
//  DeviceDataView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import SwiftUI

struct FullDeviceDataView: View {
    @Binding var fullDevice: FullDevice
    @State private var isOn: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Text(fullDevice.alias)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(fullDevice.addr)", systemImage: getBoltImage())
                Spacer()
                Button(action: {
                    var result: Bool = false
                    if isOn {
                        // TODO: Need to perform error handling here
                        result = fullDevice.switchOff()
                    } else {
                        result = fullDevice.switchOn()
                    }
                    if result {
                        isOn = fullDevice.is_on
                    }
                }) {
                    if isOn {
                        // Image(systemName: "minus")
                        Text("On")
                    } else {
                        Text("Off")
                    }
                }
            }
            Spacer()
            FullDeviceAutomationsView(fullDevice: fullDevice)
        }
        .padding()
        .onAppear {
            isOn = fullDevice.is_on
        }
    }
    
    func getBoltImage() -> String {
        if isOn {
            return "bolt.fill"
        } else {
            return "bolt"
        }
    }
}

struct DeviceDataView_Previews: PreviewProvider {
    static var previews: some View {
        FullDeviceDataView(fullDevice: .constant(FullDeviceMock.sampleData[0]))
    }
}

