//
//  DataModel.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/07/2023.
//

import Foundation

struct DataModel: Codable{
    var id = UUID()
    var carbonKg : Double
    var createdAt: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case carbonKg = "carbon_kg"
        case createdAt = "created_at"
        case name = "name"
        
    }
    
}
