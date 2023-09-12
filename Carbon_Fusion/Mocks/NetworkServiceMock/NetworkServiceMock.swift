//
//  NetworkServiceMock.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 02/09/2023.
//

import Foundation

class MockNetworkService: NetworkServiceManager {

    func request<T>(session: URLSession, method: HttpMethod, path: Path, body: Data?, completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable, T : Encodable {
        let mockedData = Data() // Replace with your mock data
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(T.self, from: mockedData)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.DecodingError))
        }
    }
}
