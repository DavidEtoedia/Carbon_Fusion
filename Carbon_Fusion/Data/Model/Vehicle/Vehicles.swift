//
//  Vehicles.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 17/07/2023.
//

import Foundation


struct VehicleMake: Codable {
    let dataModel : CarMakeModel
    
    enum CodingKeys: String, CodingKey {
        case dataModel = "data"
        
    }
}

struct CarMakeModel: Codable {
    let id,type : String
    let attribute: CarAttributes
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attribute = "attributes"
    }
}

struct CarAttributes: Codable {
    let name : String
    let modelNo: Int
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case modelNo = "number_of_models"
    }
    
}
