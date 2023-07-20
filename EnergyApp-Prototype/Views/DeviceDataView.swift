//
//  DeviceDataView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import SwiftUI

struct DeviceDataView: View {
    var deviceData: DeviceData
    var body: some View {
        //Text("\(deviceData.alias)")
        VStack {
            Text("\(deviceData.alias)")
            Spacer()
            HStack {
                Label("Something", systemImage: "bolt.fill")
            }
        }
    }
}

//struct DeviceDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceDataView(deviceData: DeviceData.sampleData[0])
//    }
//}
