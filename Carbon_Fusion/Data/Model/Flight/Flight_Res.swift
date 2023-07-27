//
//  Flight_Res.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 25/07/2023.
//

import Foundation


//"{
//"data": {
//  "id": "d60edacc-cf6c-4da7-b5de-c538de4ce5ee",
//  "type": "estimate",
//  "attributes": {
//    "passengers": 2,
//    "legs": [
//      {
//        "departure_airport": "SFO",
//        "destination_airport": "YYZ"
//      },
//      {
//        "departure_airport": "YYZ",
//        "destination_airport": "SFO"
//      }
//    ],
//    "estimated_at": "2020-07-24T02:25:50.837Z",
//    "carbon_g": 1077098,
//    "carbon_lb": 2374,
//    "carbon_kg": 1077,
//    "carbon_mt": 1,
//    "distance_unit": "km",
//    "distance_value": 7454.15
//  }
//}
//}"


//struct FlightResponseModel: Codable {
//    let data : FlightResponse
//
//    enum CodingKeys: String, CodingKey {
//        case data = "data"
//    }
//
//}
//
//
//struct FlightResponse : Codable{
//    let id : String
//    let type: String
//    let attributes: FlightAttributes
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case type = "type"
//        case attributes = "attributes"
//    }
//
//}
//
//struct FlightAttributes: Codable {
//    let passengers: Int
//    let legs: [Legs]
//    let estimatedAT : String
//    let carbong : Int
//    let carbonKg : Int
//    let carbonMt : Int
//    let carbonLb : Int
//    let distanceValue : Int
//    let distanceUnit : String
//
//    enum CodingKeys: String, CodingKey {
//        case passengers = "passengers"
//        case legs = "legs"
//        case estimatedAT = "estimated_at"
//        case carbong = "carbon_g"
//        case carbonKg = "carbon_kg"
//        case carbonMt = "carbon_mt"
//        case carbonLb = "carbon_lb"
//        case distanceValue = "distance_value"
//        case distanceUnit = "distance_unit"
//    }
//}
//
//
//
//struct Legs: Codable {
//    let departureAirport: String
//    let destinationAirport: String
//
//    enum CodingKeys: String, CodingKey {
//        case departureAirport = "departure_airport"
//        case destinationAirport = "destination_airport"
//    }
//}
//
//


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flightResponseModel = try? JSONDecoder().decode(FlightResponseModel.self, from: jsonData)

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
