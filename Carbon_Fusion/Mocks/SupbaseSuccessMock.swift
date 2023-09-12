//
//  SupbaseServiceMocks.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 01/09/2023.
//

#if DEBUG
import Foundation
import Realtime


protocol MockSupaBaseManagerProtocol {
    func request<T>(reqBody: Encodable, table: String) async throws -> T where T: Decodable
    func delete(id: String) async throws
    func getRequest<T>(table: String) async throws -> T where T: Decodable
}

class MockSupaBaseMangerImpl: MockSupaBaseManagerProtocol {
   
    func request<T>(reqBody: Encodable, table: String) async throws -> T where T: Decodable {
        // Implement your mock behavior here
        let mockData: Data = Data(mockDataModel.utf8)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: mockData)
        return decodedData
    }
    
    func delete(id: String) async throws {
        // Implement your mock behavior here
        fatalError("Mock not implemented")
    }
    
    func getRequest<T>(table: String) async throws -> T where T: Decodable {
        let mockData: Data = Data(mockDataModel.utf8)
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(T.self, from: mockData)
        return decodedData
    }
    
    func realTimeReq() -> Realtime.Channel {
        fatalError("Mock not implemented")
    }
    
   
    
    
}



let mockDataModel =
"""
 {
     "id": "25f7a534-ec04-4e9b-b30f-d2c5b3ba30bc",
     "carbon_kg": 0.4,
     "created_at": "2020-07-24T02:25:50.837Z",
     "name": "Sam"
     
 }
"""

#endif

