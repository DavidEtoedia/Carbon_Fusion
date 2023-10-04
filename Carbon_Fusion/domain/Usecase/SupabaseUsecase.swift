//
//  SupabaseUsecase.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 03/10/2023.
//

import Foundation
import Realtime


protocol SupaBaseUsecaseRepository {
    
    func saveCarbonFt(req: DataModel) async
    func getAll()async throws -> [DataModel]?
    func delete(id: String) async throws
    func realtime() -> Realtime.Channel
}


class SupaBaseUsecase : SupaBaseUsecaseRepository{

    
    @Service private var repository: SupabaseRepository
    
    func saveCarbonFt(req: DataModel)async{
       await  repository.saveCarbonFt(req: req, table: "Carbon")
    }
    
    func getAll()async throws -> [DataModel]?{
        let res: [DataModel]? = try? await  repository.getRequest(table: "Carbon")
        return res
       
    }
    
    func delete(id: String)async throws{
       try? await repository.delete(id: id)
    }
    
    func realtime() -> Realtime.Channel {
       return repository.realTime()
    }
    
}





