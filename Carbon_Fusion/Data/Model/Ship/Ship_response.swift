//
//  Ship_response.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import Foundation



// MARK: - ShipResponseModel
struct ShipResponseModel: Codable, Equatable {
    let data: ShipResponse?
    
    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

}

// MARK: - DataClass
struct ShipResponse: Codable, Equatable {
    let id: String?
    let type: String?
    let attributes: ShipAttributes?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }

}

// MARK: - Attributes
struct ShipAttributes: Codable, Equatable {
    let distance_value : Double?
    let weight_unit : String?
    let transport_method : String?
    let weight_value : Double?
    let distance_unit : String?
    let estimated_at : String?
    let carbon_g : Int?
    let carbon_lb : Double?
    let carbon_kg : Double?
    let carbon_mt : Double?

    enum CodingKeys: String, CodingKey {

        case distance_value = "distance_value"
        case weight_unit = "weight_unit"
        case transport_method = "transport_method"
        case weight_value = "weight_value"
        case distance_unit = "distance_unit"
        case estimated_at = "estimated_at"
        case carbon_g = "carbon_g"
        case carbon_lb = "carbon_lb"
        case carbon_kg = "carbon_kg"
        case carbon_mt = "carbon_mt"
    }

}




/*
 
 {
   "data": {
     "id": "4746e4ba-6605-4acc-802b-fd229a9503b4",
     "type": "estimate",
     "attributes": {
       "distance_value": "2000.0",
       "distance_unit": "km",
       "weight_value": "200.0",
       "weight_unit": "g",
       "transport_method": "truck",
       "estimated_at": "2020-07-31T13:00:04.446Z",
       "carbon_g": 25,
       "carbon_lb": 0.06,
       "carbon_kg": 0.03,
       "carbon_mt": 0.0
     }
   }
 }

 */
