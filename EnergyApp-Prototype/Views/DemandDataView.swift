//
//  DemandDataView.swift
//  EnergyApp-Prototype
//
//  Created by Richard Autry on 7/10/23.
//

import SwiftUI

struct DemandDataView: View {
    let demandData: EIAData
    
    var body: some View {
        VStack {
            Text("\(demandData.value)")
        }
    }
}
