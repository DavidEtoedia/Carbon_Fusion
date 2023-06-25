//
//  Electricity_Response.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation

struct ElectricityResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, type: String
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let country, state, electricityUnit, electricityValue: String
    let estimatedAt: String
    let carbonG, carbonLB, carbonKg, carbonMT: Int

    enum CodingKeys: String, CodingKey {
        case country, state
        case electricityUnit = "electricity_unit"
        case electricityValue = "electricity_value"
        case estimatedAt = "estimated_at"
        case carbonG = "carbon_g"
        case carbonLB = "carbon_lb"
        case carbonKg = "carbon_kg"
        case carbonMT = "carbon_mt"
    }
}
