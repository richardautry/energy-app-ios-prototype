//
//  Device.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import Foundation

final class DeviceData: RustObject {
    let id: UUID
    var raw: OpaquePointer
    
    required init(id: UUID = UUID(), raw: OpaquePointer) {
        self.id = id
        self.raw = raw
    }
    
    func intoRaw() -> OpaquePointer {
        return self.raw
    }
    
    // TODO:
//    deinit {
//
//    }
    
    var alias: String {
        get {
            return String(cString: device_data_get_alias(raw))
        }
    }
}
