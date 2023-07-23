//
//  DeviceDataView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import SwiftUI

struct FullDeviceDataView: View {
    var fullDevice: FullDevice
    var body: some View {
        VStack {
            Text("\(fullDevice.alias)")
            Spacer()
            HStack {
                Label("\(fullDevice.addr)", systemImage: "bolt.fill")
                Button(action: {
                    if fullDevice.is_on {
                        fullDevice.switchOff()
                    } else {
                        fullDevice.switchOn()
                    }
                }) {
                    if fullDevice.is_on {
                        Image(systemName: "minus")
                    } else {
                        Image(systemName: "plus")
                    }
                }
            }
            Spacer()
            Text("On: \(String(fullDevice.is_on))")
        }
    }
}

//struct DeviceDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceDataView(deviceData: DeviceData.sampleData[0])
//    }
//}
