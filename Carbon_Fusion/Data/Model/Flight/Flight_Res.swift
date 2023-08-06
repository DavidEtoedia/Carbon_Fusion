//
//  Flight_Res.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 25/07/2023.
//

import Foundation


// MARK: - FlightResponseModel


struct FlightResponseModel : Codable {
    let data : FlightResponse?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FlightResponse.self, forKey: .data)
    }

}



struct FlightResponse: Codable {
    let id: String?
    let type: String?
    let attributes: FlightAttributes?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case attributes = "attributes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        attributes = try values.decodeIfPresent(FlightAttributes.self, forKey: .attributes)
    }
}

// MARK: - Attributes
struct FlightAttributes: Codable {
    let passengers : Int?
    let legs : [Legs]?
    let distance_value : Double?
    let distance_unit : String?
    let estimated_at : String?
    let carbon_g : Int?
    let carbon_lb : Double?
    let carbon_kg : Double?
    let carbon_mt : Double?

    enum CodingKeys: String, CodingKey {

        case passengers = "passengers"
        case legs = "legs"
        case distance_value = "distance_value"
        case distance_unit = "distance_unit"
        case estimated_at = "estimated_at"
        case carbon_g = "carbon_g"
        case carbon_lb = "carbon_lb"
        case carbon_kg = "carbon_kg"
        case carbon_mt = "carbon_mt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        passengers = try values.decodeIfPresent(Int.self, forKey: .passengers)
        legs = try values.decodeIfPresent([Legs].self, forKey: .legs)
        distance_value = try values.decodeIfPresent(Double.self, forKey: .distance_value)
        distance_unit = try values.decodeIfPresent(String.self, forKey: .distance_unit)
        estimated_at = try values.decodeIfPresent(String.self, forKey: .estimated_at)
        carbon_g = try values.decodeIfPresent(Int.self, forKey: .carbon_g)
        carbon_lb = try values.decodeIfPresent(Double.self, forKey: .carbon_lb)
        carbon_kg = try values.decodeIfPresent(Double.self, forKey: .carbon_kg)
        carbon_mt = try values.decodeIfPresent(Double.self, forKey: .carbon_mt)
    }
}

// MARK: - Leg
struct Legs: Codable {
    let departure_airport : String?
    let destination_airport : String?

    enum CodingKeys: String, CodingKey {

        case departure_airport = "departure_airport"
        case destination_airport = "destination_airport"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        departure_airport = try values.decodeIfPresent(String.self, forKey: .departure_airport)
        destination_airport = try values.decodeIfPresent(String.self, forKey: .destination_airport)
    }
}








/*
 
 // MARK: - DataClass
 struct FlightResponseModel: Codable {
     let id, type: String
     let attributes: FlightAttributes
 }

 // MARK: - Attributes
 struct FlightAttributes: Codable {
     let passengers: Int
     let legs: [Leg]
     let distanceValue: Double
     let distanceUnit, estimatedAt: String
     let carbonG: Int
     let carbonLB, carbonKg, carbonMT: Double

     enum CodingKeys: String, CodingKey {
         case passengers, legs
         case distanceValue = "distance_value"
         case distanceUnit = "distance_unit"
         case estimatedAt = "estimated_at"
         case carbonG = "carbon_g"
         case carbonLB = "carbon_lb"
         case carbonKg = "carbon_kg"
         case carbonMT = "carbon_mt"
     }
 }

 // MARK: - Leg
 struct Leg: Codable {
     let departureAirport, destinationAirport: String

     enum CodingKeys: String, CodingKey {
         case departureAirport = "departure_airport"
         case destinationAirport = "destination_airport"
     }
 }
 
 
 
 
 */
