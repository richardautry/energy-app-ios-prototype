//
//  ContentView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/6/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    // TODO: Get and display current battery level
    // UIDevice.current.isBatteryMonitoringEnabled = true
    // let level = UIDevice.current.batteryLevel
    let level = UIDevice.current.batteryLevel
    let rustGreetings = RustGreetings()
    @State private var eiaData: [EIAData] = []
    @State var allFullDevices: [FullDevice] = []
    @State var textValue: String = "Before"
    
    var body: some View {
        VStack {
            Text("SmartEn")
            getTextView()
            // dataView()
            getDeviceDataView()
        }
        .onAppear {
            getFullDevices()
        }
    }
    
    func getTextView() -> some View {
        return Text(textValue).task {
            sleep(4)
            textValue = "After"
        }
    }
    
    func getFullDevices() -> Void {
        var len: UInt32 = 0
        len = 0
        let tplinkerDeviceDiscoveryPtr = tplinker_device_discovery(&len)
        print("Full Devices Length: \(len)")
        let fullDevicePtrArray = Array(UnsafeBufferPointer(start: tplinkerDeviceDiscoveryPtr, count: Int(len)))
        allFullDevices = []
        for fullDevicePtr in fullDevicePtrArray {
            let fullDevice = FullDevice(raw: fullDevicePtr)
            print("\(fullDevice.alias)")
            allFullDevices.append(fullDevice)
        }
    }
    
    func getDeviceDataView() -> some View {
        return NavigationStack {
            List($allFullDevices) { fullDevice in
                FullDeviceDataView(
                    fullDevice: fullDevice
                )
            }
            .refreshable {
                getFullDevices()
            }
        }
        
    }
    
    func dataView() -> some View {
        self.startLoad { (data)  in
            eiaData = convertDataToEIAData(data: data)
        }
        return Chart {
            ForEach(eiaData) { dataItem in
                BarMark(
                    x: .value("Period", dataItem.period),
                    y: .value("Value", dataItem.value)
                )
            }
        }
    }
    
    func startLoad(_ completion: @escaping (Data) -> Void) {
        // TODO: Build URL from params list
        // TODO: Adjust dates to build from current date
        let api_key = API.eiaAPIKey
        let start_date = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let start_date_string = getEIARequestDateFormatter().string(from: start_date)
        let end_date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let end_date_string = getEIARequestDateFormatter().string(from: end_date)

        let url = URL(string: "https://api.eia.gov/v2/electricity/rto/region-data/data/?api_key=\(api_key)&frequency=local-hourly&data[0]=value&facets[respondent][]=MIDA&start=\(start_date_string)&end=\(end_date_string)"
        )!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // self.handleClientError(error)
                print("ERROR")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // self.handleServerError(response)
                print("Wrong status code: \(String(describing: response))")  // TODO: Print status code
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
               let data = data {
                completion(data)
            }
        }
        task.resume()
    }
    
    func convertDataToEIAData(data: Data) -> [EIAData] {
        var return_data: [EIAData] = []
        do {
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            let response = json["response"] as! Dictionary<String, AnyObject>
            let all_data = response["data"] as! Array<Dictionary<String, AnyObject>>
            var converted_data: [EIAData] = []
            for data_item in all_data {
                converted_data.append(EIAData(json_data: data_item))
            }
            // TODO: Compare to current day
            // Right now this is showing previous demand. Will need to get actual forecast directly from PJM for real-time data
            return_data = converted_data.filter {
                $0.type == "D" &&
                $0.period >= Calendar.current.date(byAdding: .day, value: -2, to: Date())! &&
                $0.period <= Calendar.current.date(byAdding: .hour, value: -12, to: Date())!
            }
        } catch {
            print("\(error)")
        }
        return return_data
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
