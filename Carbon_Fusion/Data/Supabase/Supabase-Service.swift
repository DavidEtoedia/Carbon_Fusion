//
//  Supabase-Service.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/07/2023.
//

import Foundation
import Realtime
import Supabase


protocol SupaBaseManager {
    func  request<T: Decodable>(reqBody: Encodable, table: String) async throws -> T
    func  delete(id: String) async throws -> Void
    func  getRequest<T: Decodable>(table: String) async throws -> T
    func realTimeReq() -> Channel
}


final class SupaBaseService: SupaBaseManager {

    private var client = SupabaseClient(supabaseURL: .supaBaseUrl(), supabaseKey: apiKey)
    var realtimeClient = RealtimeClient(endPoint: "https://dzdaoqpmncbxxnbotvmz.supabase.co/realtime/v1", params: ["apikey": apiKey])
 
    
    init() {
//        print("connect to Supabase realtime")
     realtimeClient.connect()
    }

    func request<T>(reqBody: Encodable, table: String) async throws -> T where T : Decodable{

        do{
            let res = try await client.database.from(table).insert(values: reqBody, returning: .representation).single().execute().underlyingResponse.data
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: res)
            return decodedData
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func delete(id: String) async throws  {
        do {
            try await client.database.from("Carbon").delete().eq(column: "id", value: id).execute()
           
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
 
    func getRequest<T>(table: String) async throws -> T where T : Decodable {
        do{
            let res = try await client.database.from(table).select().order(column: "created_at", ascending: false).execute().underlyingResponse.data
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(T.self, from: res) else {
                return T.self as! T
            }
           
            return decodedData
        }
        catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func realTimeReq() -> Realtime.Channel {
       let result = realtimeClient.channel(.table("Carbon", schema: "public"))
        return result
    }
    
    func req(){
        let userChanges = realtimeClient.channel(.table("Carbon", schema: "public"))
        userChanges.on(.all) { message in
            print(message.payload)
        }
        userChanges.subscribe()
    }
 
}




protocol SupaBaseRepository {
    func saveCarbonFt(req: DataModel, table: String)  -> Void
    func delete(id: String) async throws -> Void
    func getRequest(table: String) async throws -> [DataModel]?
    func realTime() -> Realtime.Channel
}

class SupaBaseRepoImpl: SupaBaseRepository  {
 
  
    @Service  private var supaBaseService: SupaBaseManager
    
    func saveCarbonFt(req: DataModel, table: String)  -> Void {
        Task{
            
            let res: DataModel? =  try? await supaBaseService.request(reqBody: req, table: table)
            guard let _ = res else {
                print("AN Error occured\(String(describing: res?.carbonKg))")
                return
            }
        }
    }
    
    
    func delete(id: String) async throws {
        do {
            try await supaBaseService.delete(id: id)
        }
        catch {
            throw error
        }
    }
    
    
    func getRequest(table: String) async throws -> [DataModel]? {
        do{
            let res: [DataModel]? = try await supaBaseService.getRequest(table: table)
            return res
        }
        catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    
    func realTime() -> Realtime.Channel {
        return supaBaseService.realTimeReq()
    }
    
}


