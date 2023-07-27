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
        VStack {
            Text("\(fullDevice.alias)")
            Spacer()
            HStack {
                Label("\(fullDevice.addr)", systemImage: "bolt.fill")
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
                        Image(systemName: "minus")
                    } else {
                        Image(systemName: "plus")
                    }
                }
            }
            Spacer()
            Text("On: \(String(isOn))")
        }
        .onAppear {
            isOn = fullDevice.is_on
        }
    }
}

//struct DeviceDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceDataView(deviceData: DeviceData.sampleData[0])
//    }
//}
