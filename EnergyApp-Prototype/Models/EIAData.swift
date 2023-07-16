//
//  EIAData.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/10/23.
//

import Foundation

struct EIAData: Identifiable {
    let id: UUID
    var period: Date
    var respondent: String
    var respondent_name: String
    var type: String
    var type_name: String
    var value: Int
    var value_units: String
    
    init(id: UUID = UUID(), json_data: Dictionary<String, AnyObject>) {
        self.id = id
        self.period = periodStringToDate(period: json_data["period"] as! String)
        self.respondent = json_data["respondent"] as! String
        self.respondent_name = json_data["respondent-name"] as! String
        self.type = json_data["type"] as! String
        self.type_name = json_data["type-name"] as! String
        self.value = json_data["value"] as! Int
        self.value_units = json_data["value-units"] as! String
    }
}

func getEIAResponseDateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HHZ"
    return dateFormatter
}

func getEIARequestDateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    return dateFormatter
}

func periodStringToDate(period: String) -> Date {
    // TODO: This needs to be strong typed. Issue with date (period) format causes crash
    return getEIAResponseDateFormatter().date(from: period)!
}

extension EIAData {
    static var some_data: [String: Any] = [
        "period": "2023-06-23T20-04",
        "respondent": "MIDA",
        "respondent-name": "Mid-Atlantic",
        "type": "D",
        "type-name": "Demand",
        "value": 98464,
        "value-units": "megawatthours"
    ]
    static let sampleData: [EIAData] = [
        EIAData(json_data: some_data as Dictionary<String, AnyObject>)
    ]
}
