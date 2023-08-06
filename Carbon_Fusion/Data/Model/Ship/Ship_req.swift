//
//  Ship_req.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import Foundation

/*
 {
     "type": "shipping",
     "weight_value": 200,
     "weight_unit": "g",
     "distance_value": 2000,
     "distance_unit": "km",
     "transport_method": "truck"
   }
 */

struct ShippingReq: Codable {
    let type: String
    let weightValue: Int
    let weightUnit: String
    let distanceValue: Int
    let distanceUnit: String
    let transportMethod: String
    
    enum CodingKeys: String, CodingKey{
        case type = "type"
        case weightValue = "weight_value"
        case weightUnit = "weight_unit"
        case distanceValue = "distance_value"
        case distanceUnit = "distance_unit"
        case transportMethod = "transport_method"
    }
}




