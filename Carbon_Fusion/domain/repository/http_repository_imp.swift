//
//  http_repository_imp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


protocol HttpRepository {
    
    func postCal<T: Codable> (body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void)
    func postVehicle<T: Codable> (body: T, completion: @escaping (Result<VehicleResponse, ApiError>) -> Void)
    func createFlight<T: Codable> (body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void)
    func getVehicle(completion: @escaping (Result<[VehicleResponse], ApiError>) -> Void)
    
}


final class HttpRepositoryImp : HttpRepository {
    @Service  private var networkService: NetworkServiceManager
    
    //MARK: Post Energy request
    
    func postCal<T>(body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(method: .post, path: .estimate, body: encoded) {  (result: Result<ElectricityResponse, ApiError>) in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    //
    //MARK: Post vehicle request
    //
    
    func postVehicle<T>(body: T, completion: @escaping (Result<VehicleResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(method: .post, path: .estimate, body: encoded) {  (result: Result<VehicleResponse, ApiError>) in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
            
            
        }
    }
    
    
    func getVehicle(completion: @escaping (Result<[VehicleResponse], ApiError>) -> Void) {
        networkService.request(method: .get, path: .createVehicle, body: nil) { (result: Result<[VehicleResponse], ApiError>) in
            switch result {
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    func createFlight<T>(body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(method: .post, path: .estimate, body: encoded) { (result: Result<FlightResponseModel, ApiError>) in
            switch result{
            case .success(let res):
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
            
        }
    }
    
    
}
    
    
    


