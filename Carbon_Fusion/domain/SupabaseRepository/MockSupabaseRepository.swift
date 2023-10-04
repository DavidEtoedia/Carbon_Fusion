//
//  SupabaseSuccessRepo.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 01/09/2023.
//

#if DEBUG

import Foundation
import Realtime



class MockSupaBaseRepository: SupabaseRepository {

    var saveCarbonFtCalled = false
    var deleteCalled = false
    var getRequestCalled = false
    var realTimeCalled = false
    
    func saveCarbonFt(req: DataModel, table: String) {
        saveCarbonFtCalled = true
    }
    
    func delete(id: String) async throws {
        deleteCalled = true
    }
    
    func getRequest(table: String) async throws -> [DataModel]? {
        getRequestCalled = true
        let result = [DataModel(carbonKg: 0.4, createdAt: "", name: ""),  DataModel(carbonKg: 0.4, createdAt: "", name: "")]
        return result
    }
    
}

#endif




//class SupaBaseRepoImplTests: XCTestCase {
//    func testSaveCarbonFt() {
//        let mockRepository = MockSupaBaseRepository()
//        let supaBaseRepoImpl = SupaBaseRepoImpl(supaBaseService: SupaBaseManager()) // Create the implementation with your actual service
//
//        // Inject the mock repository
//        supaBaseRepoImpl.repository = mockRepository
//
//        // Perform the action that triggers saveCarbonFt
//        supaBaseRepoImpl.saveCarbonFt(req: DataModel(carbonKg: 0.4, createdAt: "", name: "Energy"), table: "Carbon")
//
//        XCTAssertTrue(mockRepository.saveCarbonFtCalled)
//    }
//
//    // Similarly, write tests for other methods like delete, getRequest, and realTime
//}
