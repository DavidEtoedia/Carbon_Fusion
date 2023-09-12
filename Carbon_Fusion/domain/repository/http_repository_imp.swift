//
//  http_repository_imp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


protocol HttpRepository {
    
    func createEnergy<T: Codable> (session: URLSession, body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void)
    func createFlight<T: Codable> (session: URLSession, body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void)
    func createShipping<T: Codable> (session: URLSession, body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void)
    
}


class HttpRepositoryImp : HttpRepository {
    
    @Service  private var networkService: NetworkServiceManager
    @Service  private var supaBaseRepo: SupaBaseRepository
    
   
    
    //MARK: Post Energy request
    
    func createEnergy<T>(session: URLSession = .customSession, body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let encoded =  try? JsonMapper.encode(body) else {
            completion(.failure(.EncodingError))
            return
        }
        networkService.request(session: session, method: .post, path: .estimate, body: encoded) {  (result: Result<ElectricityResponse, ApiError>) in
            switch result {
            case .success(let res):
                let data = DataModel(carbonKg: (res.datum?.attributes?.carbon_kg)!, createdAt: (res.datum?.attributes?.estimated_at!)!, name: "Energy")
                Task{
                    self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
                }
                
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
                let data = DataModel(carbonKg: (res.data?.attributes?.carbon_mt)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Flight")
                
                self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
                
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
                let data = DataModel(carbonKg: (res.data?.attributes?.carbon_kg)!, createdAt: (res.data?.attributes?.estimated_at!)!, name: "Logistics")
                self.supaBaseRepo.saveCarbonFt(req: data, table: "Carbon")
                
                completion(.success(res))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    
}
    
    
    


