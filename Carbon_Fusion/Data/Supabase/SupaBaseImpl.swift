//
//  SupaBaseImpl.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 02/10/2023.
//

import Foundation
import Realtime

class SupabaseServiceImpl : SupabaseRepository {
    @Service private var supabaseService: SupaBaseManager
    
    
    func saveCarbonFt(req: DataModel, table: String) async {
        let _: DataModel? = try? await supabaseService.request(reqBody: req, table: "Carbon")
    }
    
    func delete(id: String) async throws {
        try await supabaseService.delete(id: id)
    }
    
    func getRequest(table: String) async throws -> [DataModel]? {
        return  try await  supabaseService.getRequest(table: "Carbon")
    }
    
    func realTime() -> Realtime.Channel {
        return supabaseService.realTimeReq()
    }
    
}
