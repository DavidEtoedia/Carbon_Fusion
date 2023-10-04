//
//  MockApiImpl.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 03/10/2023.
//

import Foundation

class MockApiImplementation: ApiRepository {
    func createEnergy<T>(body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        let mockResponse = ElectricityResponse(datum: Datum(id: "", type: "", attributes: Attributes(country: "", state: "", electricity_unit: "", electricity_value: 0.0, estimated_at: "", carbon_g: 0, carbon_lb: 0.0, carbon_kg: 0.0, carbon_mt: 0.0)))
        completion(.success(mockResponse))
    }
    
    func createFlight<T>(body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        let mockResponse = FlightResponseModel(data: FlightResponse(id: "", type: "", attributes: FlightAttributes(passengers: 0, legs: [], distance_value: 0.0, distance_unit: "", estimated_at: "", carbon_g: 0, carbon_lb: 0.0, carbon_kg: 0.0, carbon_mt: 0.0)))
        completion(.success(mockResponse))
    }
    
    func createShipping<T>(body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        let mockResponse = ShipResponseModel( data: ShipResponse(id: "", type: "", attributes: ShipAttributes(distance_value: 0.0, weight_unit: "", transport_method: "", weight_value: 0.0, distance_unit: "", estimated_at: "", carbon_g: 0, carbon_lb: 0.0, carbon_kg: 0.0, carbon_mt: 0.0)))
        completion(.success(mockResponse))
    }
    

}
