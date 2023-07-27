//
//  Device.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import Foundation

class FullDevice: RustObject {
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

class FullDeviceMock: FullDevice {
    var prevIsOn: Bool = false
    
    override var alias: String {
        get {
            return "MockAlias"
        }
    }
    override var addr: String {
        get {
            "192.168.1.251:9999"
        }
    }
    override var is_on: Bool {
        get {
            if prevIsOn == true {
                return false
            } else {
                return true
            }
        }
    }
    override func switchOff() -> Bool {
        return true
    }
    override func switchOn() -> Bool {
        return true
    }
}
