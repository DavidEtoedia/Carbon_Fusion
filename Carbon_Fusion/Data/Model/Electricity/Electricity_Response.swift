//
//  Electricity_Response.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation


struct ElectricityResponse : Codable, Equatable {
    var datum : Datum?

    enum CodingKeys: String, CodingKey {

        case datum = "data"
    }

}

struct Datum : Codable, Equatable {
    let id : String?
    let type : String?
    let attributes : Attributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }

}


struct Attributes : Codable, Equatable {
    let country : String?
    let state : String?
    let electricity_unit : String?
    let electricity_value : Double?
    let estimated_at : String?
    let carbon_g : Int?
    let carbon_lb : Double?
    let carbon_kg : Double?
    let carbon_mt : Double?

    enum CodingKeys: String, CodingKey {

        case country = "country"
        case state = "state"
        case electricity_unit = "electricity_unit"
        case electricity_value = "electricity_value"
        case estimated_at = "estimated_at"
        case carbon_g = "carbon_g"
        case carbon_lb = "carbon_lb"
        case carbon_kg = "carbon_kg"
        case carbon_mt = "carbon_mt"
    }

}
