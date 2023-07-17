//
//  network_manager.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/05/2023.
//

import Foundation


protocol NetworkManager {
    func postElect<T: Codable> (body: T, completion: @escaping (Result<Data?, ApiError>) -> Void)
    func postData(from url: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void) -> URLSessionDataTask
 
    
}


final class NetworkManagerImpl: NetworkManager {
  
    @Service private var urlSession: URLSession
    
    
    func postData(from url: URLRequest, completion: @escaping (Result<Data, ApiError>) -> Void) -> URLSessionDataTask {
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
            guard  let httpRes = response as? HTTPURLResponse,
                   (200..<300).contains(httpRes.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(.failure(.errorCode(statusCode ?? 0)))
                return
            }
            guard let data = data else {
                let _ = NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data"])
                completion(.failure(.DecodingError))
            
                return
            }
            
            completion(.success(data))
        }
        
        return task

    }
    
    

    
    func postElect<T>(body: T, completion: @escaping (Result<Data?, ApiError>) -> Void) where T : Decodable, T : Encodable {
        guard let encoded = try? JSONEncoder().encode(body) else {
            print("Failed to encode order")
            return
        }
        
        let _ = URLSession.shared.dataTask(with: .urlRequest(HTTPMethod.post, data: encoded)) { (data, response, error) in
            guard  let httpRes = response as? HTTPURLResponse,
                   (200..<300).contains(httpRes.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(.failure(.errorCode(statusCode ?? 0)))
                return
            }
        }
    }
    
    func getElectricity(){
        let elect = ElectricityReq(type: "electricity", electricityUnit: "mwh", electricityValue: 3, country: "us", state: "fl")
        guard let encoded = try? JSONEncoder().encode(elect) else {
            print("Failed to encode order")
            return
        }
        
        let _ = URLSession.shared.dataTask(with: .urlRequest(HTTPMethod.post, data: encoded)) { (data, response, error) in
        }

        
    }
    
    
    
}




enum ApiError : Error {
    case DecodingError
    case EncodingError
    case errorCode(Int)
    case unknown
}

    extension ApiError : LocalizedError {
        var errorDescription: String? {
            switch self{
            case.DecodingError:
                return "An Error Occurred While Decoding"
            case.errorCode( let code):
                return handleError(statusCode: code)
            case .unknown:
                return "an Unknown Error occurred"
            case .EncodingError:
                return "An Error Occurred While Encoding"
            }
        }
        
        
        
      func handleError(statusCode:  Int) -> String {
          switch (statusCode) {
            case 400:
              return "Bad request";
            case 401:
              return "Unauthorized";
            case 403:
              return "Forbidden response";
            case 404:
              return "requested page is not available";
            case 500:
              return "Internal server error";
            case 502:
              return "Bad gateway";
            case 504:
              return "Service unavaiilable. Please try again later";
          case 422:
            return "An error occurred .. Please try again";
            default:
              return "Oops something went wrong";
          }
        }
    }







