//
//  http_repository_imp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


protocol HttpRepository {
    
    func createEnergy<T: Codable> (body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void)
    func postVehicle<T: Codable> (body: T, completion: @escaping (Result<VehicleResponse, ApiError>) -> Void)
    func createFlight<T: Codable> (body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void)
    func createShipping<T: Codable> (body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void)
    func getVehicle(completion: @escaping (Result<[VehicleResponse], ApiError>) -> Void)
    
}


final class HttpRepositoryImp : HttpRepository {
  
    @Service  private var networkService: NetworkServiceManager
    @Service  private var supaBaseRepo: SupaBaseRepository

    
    //MARK: Post Energy request
    
    func createEnergy<T>(body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(method: .post, path: .estimate, body: encoded) {  (result: Result<ElectricityResponse, ApiError>) in
            switch result {
            case .success(let res):
                completion(.success(res))
                let data = DataModel(carbonKg: (res.datum?.attributes?.carbon_kg)!, createdAt: (res.datum?.attributes?.estimated_at!)!, name: "Energy")
                Task{
                 self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
                }
               
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    //
    //MARK: Post vehicle request
    
    
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
                let data = DataModel(carbonKg: (res.data?.attributes?.carbon_mt)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Flight")
                
                 self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
                
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
            
        }
    }
    
    
    func createShipping<T>(body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded = try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(method: .post, path: .estimate, body: encoded) { (result: Result<ShipResponseModel, ApiError>) in
                switch result {
                case .success(let res):
                    let data = DataModel(carbonKg: (res.data?.attributes?.carbon_kg)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Logistics")
                    
                     self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
            
                    completion(.success(res))
                case .failure(let err):
                    completion(.failure(err))
                }
        }
    }
    
    
    
}
    
    
    


