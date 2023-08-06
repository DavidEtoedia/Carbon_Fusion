//
//  Network_service.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 17/07/2023.
//

import Foundation


protocol NetworkServiceManager {
    func request<T: Codable>(
         method: HttpMethod,
         path: Path,
         body: Data?,
         completion: @escaping (Result<T, ApiError>) -> Void
     )}



final class NetworkService: NetworkServiceManager {
    func request<T>(method: HttpMethod, path: Path, body: Data?, completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable, T : Encodable {
        var request = URLRequest(url: uRLComponents(path: path)!)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        // URL Session config
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60 // seconds that a task will wait for data to arrive
        configuration.timeoutIntervalForResource = 300
        
        let session = URLSession(configuration: configuration)
        
        // Headers
        request.setValue("Bearer \(ApiKey.apiKey.description)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
         //MARK: Set headers here ------------->>>>>>>>>>>>>
        /*
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)      }
        */
        
        session.dataTask(with: request) { data, response, error in
            
            //MARK: Check for error
            if let _ = error {
                completion(.failure(.unknown))
                return
            }
                        
            //MARK: Check for http response error
            
            guard  let httpRes = response as? HTTPURLResponse,
                   (200..<300).contains(httpRes.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(.failure(.errorCode(statusCode ?? 0)))
                return
            }
            
            //MARK: Check if the data is a valid data
            
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            //MARK: Decode data is if data is valid
            do {
                let decoder = JSONDecoder()
          
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.DecodingError))
            }
        }.resume()
    }
    
    
    //MARK: Set URL component  here ------------->>>>>>>>>>>>>
    func uRLComponents(path: Path) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "www.carboninterface.com"
        urlComponents.path = "/api/v1\(path.rawValue)"
       // urlComponents.percentEncodedQuery = "Authorization=Bearer\(ApiKey.apiKey.description)"
        
        return urlComponents.url
    }
    

}
