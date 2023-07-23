//
//  Device.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import Foundation

final class FullDevice: RustObject {
    let id: UUID
    var raw: OpaquePointer
    
    required init(id: UUID = UUID(), raw: OpaquePointer) {
        self.id = id
        self.raw = raw
    }
    
    func intoRaw() -> OpaquePointer {
        return self.raw
    }
    
    var alias: String {
        get {
            return String(cString: full_device_get_alias(raw))
        }
    }
    
    var addr: String {
        get {
            return String(cString: full_device_get_addr(raw))
        }
    }
    
    var is_on: Bool {
        get {
            return full_device_is_on(raw)
        }
    }
    
    func switchOff() -> Bool {
        return full_device_switch_off(raw)
    }
    
    func switchOn() -> Bool {
        return full_device_switch_on(raw)
    }
}
