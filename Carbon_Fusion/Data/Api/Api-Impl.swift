//
//  Api-Impl.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 02/10/2023.
//

import Foundation

class ApiImplementation : ApiRepository {
    
    @Service private var apiService: HttpNetworkService
    @Service private var supabase: SupaBaseManager
    
    func createEnergy<T>(body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        apiService.createEnergy(body: body) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func createFlight<T>( body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        apiService.createFlight(body: body) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func createShipping<T>(body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        apiService.createShipping(body: body) { result in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    
    
}
