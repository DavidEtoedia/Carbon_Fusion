// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flightReq = try? JSONDecoder().decode(FlightReq.self, from: jsonData)

import Foundation

// MARK: - FlightReq
struct FlightReq: Codable {
    let type: String
    let passengers: Int
    let legs: [LegReq]
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case passengers = "passengers"
        case legs = "legs"
    }
}

// MARK: - Leg
struct LegReq: Codable {
    let departureAirport: String
    let destinationAirport: String

    enum CodingKeys: String, CodingKey {
        case departureAirport = "departure_airport"
        case destinationAirport = "destination_airport"
    }
}
