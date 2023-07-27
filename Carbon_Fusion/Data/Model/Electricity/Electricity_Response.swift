//
//  Electricity_Response.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation

//struct ElectricityResponse: Codable {
//    let data: DataClass
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//}
//
//
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let id, type: String
//    let attributes: Attributes
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case type = "type"
//        case attributes = "attributes"
//    }
//}
//
//// MARK: - Attributes
//struct Attributes: Codable {
//    let country, state, electricityUnit, electricityValue: String
//    let estimatedAt: String
//    let carbonG, carbonLB, carbonKg, carbonMT: Int
//
//    enum CodingKeys: String, CodingKey {
//        case country, state
//        case electricityUnit = "electricity_unit"
//        case electricityValue = "electricity_value"
//        case estimatedAt = "estimated_at"
//        case carbonG = "carbon_g"
//        case carbonLB = "carbon_lb"
//        case carbonKg = "carbon_kg"
//        case carbonMT = "carbon_mt"
//    }
//}




struct ElectricityResponse : Codable {
    var datum : Datum?

    enum CodingKeys: String, CodingKey {

        case datum = "data"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        datum = try values.decodeIfPresent(Datum.self, forKey: .datum)
//    }

}

struct Datum : Codable {
    let id : String?
    let type : String?
    let attributes : Attributes?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        type = try values.decodeIfPresent(String.self, forKey: .type)
//        attributes = try values.decodeIfPresent(Attributes.self, forKey: .attributes)
//    }

}


struct Attributes : Codable {
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

//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        country = try values.decodeIfPresent(String.self, forKey: .country)
//        state = try values.decodeIfPresent(String.self, forKey: .state)
//        electricity_unit = try values.decodeIfPresent(String.self, forKey: .electricity_unit)
//        electricity_value = try values.decodeIfPresent(Double.self, forKey: .electricity_value)
//        estimated_at = try values.decodeIfPresent(String.self, forKey: .estimated_at)
//        carbon_g = try values.decodeIfPresent(Int.self, forKey: .carbon_g)
//        carbon_lb = try values.decodeIfPresent(Double.self, forKey: .carbon_lb)
//        carbon_kg = try values.decodeIfPresent(Double.self, forKey: .carbon_kg)
//        carbon_mt = try values.decodeIfPresent(Double.self, forKey: .carbon_mt)
//    }

}
