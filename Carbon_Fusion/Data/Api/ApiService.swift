//
//  ApiService.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 02/10/2023.
//

import Foundation




class HttpNetworkService {
    
    @Service  private var networkService: NetworkServiceManager
    
    //MARK: Post Energy request
    
    func createEnergy<T>(session: URLSession = .customSession, body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(session: session, method: .post, path: .estimate, body: encoded) {  (result: Result<ElectricityResponse, ApiError>) in
            switch result {
            case .success(let res):
                
                completion(.success(res))
                
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    //
    
    
    
    func createFlight<T>(session: URLSession = .customSession, body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(session: session, method: .post, path: .estimate, body: encoded) { (result: Result<FlightResponseModel, ApiError>) in
            switch result{
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
            
        }
    }
    
    
    func createShipping<T>(session: URLSession = .customSession, body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded = try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(session: session, method: .post, path: .estimate, body: encoded) { (result: Result<ShipResponseModel, ApiError>) in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    
}
