//
//  MockSupabaseServiceImpl.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 03/10/2023.
//

import Foundation
import Realtime

class MockSupabaseServiceImpl : SupabaseRepository {
    
    func saveCarbonFt(req: DataModel, table: String) {
       return
    }
    
    func delete(id: String) async throws {
        return
    }
    
    func getRequest(table: String) async throws -> [DataModel]? {
        let result = [DataModel(carbonKg: 0.4, createdAt: "", name: ""),  DataModel(carbonKg: 0.4, createdAt: "", name: "")]
        return result
    }
    
}
