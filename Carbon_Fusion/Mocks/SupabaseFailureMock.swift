//
//  SupabaseFailureMock.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 01/09/2023.
//


#if DEBUG
import Foundation

class MockSupaBaseFailureService: MockSupaBaseManagerProtocol {
    func request<T>(reqBody: Encodable, table: String) async throws -> T where T: Decodable {
        throw ApiError.errorCode(400)
    }
    
    func delete(id: String) async throws {
        // Implement your mock behavior here
        fatalError("Mock not implemented")
    }
    
    func getRequest<T>(table: String) async throws -> T where T: Decodable {
        // Implement your mock behavior here
        fatalError("Mock not implemented")
    }
}
#endif

