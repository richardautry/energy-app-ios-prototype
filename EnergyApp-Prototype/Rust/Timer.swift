//
//  Timer.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 8/5/23.
//

import Foundation

class Timer: Identifiable {
    let id: UUID
    var raw: OpaquePointer
    
    required init(id: UUID = UUID()) {
        self.id = id
        self.raw = get_timer(0)
    }
    
    func intoRaw() -> OpaquePointer {
        return self.raw
    }
    
    var seconds: UInt32 {
        get {
            return poll_timer(raw)
        }
    }
}
