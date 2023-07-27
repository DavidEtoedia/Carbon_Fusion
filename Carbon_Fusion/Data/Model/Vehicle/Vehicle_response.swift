//
//  Vehicle_response.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/07/2023.
//

import Foundation

struct VehicleResponse: Codable {
    var vehicleData: VehicleData?
    
    enum CodingKeys: String, CodingKey {
        case vehicleData = "data"
        
    }
}

struct VehicleData: Codable {
    let id : String
    let type: String
    let attributes: VehicleAttributes
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }
}


struct VehicleAttributes: Codable {
    let distanceValue: Double?
    let vehicleModel: String?
    let vehicleMake: String?
    let vehicleYear: Int?
    let vehicleModelId: String?
    let distanceUnit: String?
    let estimatedAt: String?
    let carbonKg: Double?
    let carbonLb: Double?
    let carbonMt: Double?
    
    enum CodingKeys: String, CodingKey {
        case distanceValue = "distance_value"
        case vehicleModel = "vehicle_model"
        case vehicleMake = "vehicle_make"
        case vehicleYear = "vehicle_year"
        case vehicleModelId = "vehicle_model_id"
        case distanceUnit = "distance_unit"
        case estimatedAt = "estimated_at"
        case carbonKg = "carbon_kg"
        case carbonLb =  "carbon_lb"
        case carbonMt =  "carbon_mt"
    }
    
}

/*
 
 "distance_value": 100.0,
    "vehicle_make": "Toyota",
    "vehicle_model": "Corolla",
    "vehicle_year": 1993,
    "vehicle_model_id": "7268a9b7-17e8-4c8d-acca-57059252afe9",
    "distance_unit": "mi",
    "estimated_at": "2021-01-10T15:24:32.568Z",
    "carbon_g": 37029,
    "carbon_lb": 81.64,
    "carbon_kg": 37.03,
    "carbon_mt": 0.04
 
 
 */
