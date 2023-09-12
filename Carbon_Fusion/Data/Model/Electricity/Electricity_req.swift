//
//  Electricity_req.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/05/2023.
//



import Foundation

// MARK: - ElectricityReq
struct ElectricityReq: Codable {
    let type, electricityUnit: String
    let electricityValue: Int
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case type
        case electricityUnit = "electricity_unit"
        case electricityValue = "electricity_value"
        case country, state
    }
}
