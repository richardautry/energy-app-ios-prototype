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
    @State private var eiaData: [EIAData] = []
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            dataView()
        }
    }
    
    func dataView() -> some View {
        self.startLoad { (data)  in
            eiaData = convertDataToEIAData(data: data)
        }
        return List(eiaData) { dataItem in
            Text("\(dataItem.value)")
        }
    }
    
    func startLoad(_ completion: @escaping (Data) -> Void) {
        // TODO: Build URL from params list
        // TODO: Adjust dates to build from current date
        let api_key = API.eiaAPIKey
//        let params = [
//            "api_key": API.eiaAPIKey
//        ]
        // let url = URL(string: "https://api.eia.gov/v2/electricity/rto/region-data/data/")!
        let url = URL(string: "https://api.eia.gov/v2/electricity/rto/region-data/data/?api_key=\(api_key)&frequency=local-hourly&data[0]=value&facets[respondent][]=MIDA&start=2023-06-24T00:00:00-04:00&end=2023-07-01T00:00:00-04:00"
        )!
    //    var request = URLRequest(url: url)
    //    request.httpMethod = "GET"
    //    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
    //    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // self.handleClientError(error)
                print("ERROR")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                // self.handleServerError(response)
                print("Wrong status code")  // TODO: Print status code
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
            return_data = converted_data.filter {
                $0.type == "D" &&
                $0.period.starts(with: "2023-06-30")
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


// TODO: Convert json to EIAData
//do {
//    let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
//    let response = json["response"] as! Dictionary<String, AnyObject>
//    let all_data = response["data"] as! Array<Dictionary<String, AnyObject>>
//    var converted_data: [EIAData] = []
//    for data_item in all_data {
//        converted_data.append(EIAData(json_data: data_item))
//    }
//    let demand_data = converted_data.filter {
//        $0.type == "D" &&
//        $0.period.starts(with: "2023-06-30")
//    }
//} catch {
//    print("Error")
//}


