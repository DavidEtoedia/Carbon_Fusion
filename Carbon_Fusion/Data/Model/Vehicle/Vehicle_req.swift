//
//  Vehicle_req.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/07/2023.
//

import Foundation


struct VehicleReq: Codable {
    
    let type, distanceUint, vehicleModelId: String
    let distanceValue: Int
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case distanceUint = "distance_unit"
        case vehicleModelId = "vehicle_model_id"
        case distanceValue = "distance_value"
    }
}



