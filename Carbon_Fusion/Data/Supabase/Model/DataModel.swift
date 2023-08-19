//
//  DataModel.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/07/2023.
//

import Foundation

struct DataModel: Codable, Identifiable{
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


var mockResponse = [

    DataModel(carbonKg: 1.4, createdAt: "2023-04-29 05:09:08.687", name: "Energy"),
    DataModel(carbonKg: 4.5, createdAt: "2023-05-29 10:09:08.687", name: "Logistics"),
    DataModel(carbonKg: 2.4, createdAt: "2023-07-29 06:09:08.687", name: "Flight"),
    DataModel(carbonKg: 1.1, createdAt: "2023-06-29 10:09:08.687", name: "Energy"),
    DataModel(carbonKg: 5.5, createdAt: "2023-05-29 08:09:08.687", name: "Energy"),
    DataModel(carbonKg: 6.3, createdAt: "2023-08-29 11:09:08.687", name: "Energy"),
    DataModel(carbonKg: 3.4, createdAt: "2023-05-29 05:09:08.687", name: "Flight"),
    DataModel(carbonKg: 10.3, createdAt: "2023-08-29 11:09:08.687", name: "Logistics"),
    DataModel(carbonKg: 3.4, createdAt: "2023-05-29 02:09:08.687", name: "Flight"),
    DataModel(carbonKg: 10.3, createdAt: "2023-08-29 11:09:08.687", name: "Logistics"),
    DataModel(carbonKg: 3.4, createdAt: "2023-05-29 05:09:08.687", name: "Logistics"),
    DataModel(carbonKg: 6.4, createdAt: "2023-05-29 05:09:08.687", name: "Flight"),
    DataModel(carbonKg: 1.4, createdAt: "2023-05-29 05:09:08.687", name: "Flight"),
    DataModel(carbonKg: 10.4, createdAt: "2023-05-29 05:09:08.687", name: "Flight"),


]
