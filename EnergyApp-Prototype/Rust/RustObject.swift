//
//  RustObject.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/20/23.
//

import Foundation

protocol RustObject: Identifiable {
    init(id: UUID, raw: OpaquePointer)
    func intoRaw() -> OpaquePointer
}
