//
//  Configuration.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/12/23.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {
    static var eiaAPIKey: String {
        //return try! URL(string: "https://" + Configuration.value(for: "BASE_URL"))!
        return try! Configuration.value(for: "EIA_API_KEY")
    }
}
