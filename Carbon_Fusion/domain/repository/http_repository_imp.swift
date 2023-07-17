//
//  http_repository_imp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


protocol HttpRepository {
    
    func postCal<T: Codable> (body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void)
    
}


final class HttpRepositoryImp : HttpRepository {
    
    @Service private var networkManager: NetworkManager
    
    
    func postCal<T>(body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void) where T : Decodable, T : Encodable {
        
        guard let encoded =  try? JsonMapper.encode(body) else {
            print("Failed to encode order")
            return
        }
        let task =  networkManager.postData(from: .urlRequest(HTTPMethod.post, data: encoded)) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(ElectricityResponse.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.DecodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
         task.resume()
        
        
    }
    
    
}

