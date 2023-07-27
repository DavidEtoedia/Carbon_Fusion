//
//  Vehicle_Sheet.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/07/2023.
//

import SwiftUI

struct Vehicle_Sheet: View {
    @EnvironmentObject private var vehicleVm: VehicleViewModel
    var body: some View {
        if(vehicleVm.result.isLoading){
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red)) // Set the color here
        } else {
            
            VStack {
                ForEach(vehicleVm.result.value ?? [], id: \.vehicleData?.id) { value in
                    Text(value.vehicleData?.type ?? "")
                    
                }
            }
            
        }
    }
}

struct Vehicle_Sheet_Previews: PreviewProvider {
    static var previews: some View {
        Vehicle_Sheet()
            .environmentObject(VehicleViewModel())
    }
}
