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
    static let shared = SupaBaseService()
    
    
   private init() {
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
   
//    func req(){
//        let userChanges = realtimeClient.channel(.table("Carbon", schema: "public"))
//        userChanges.on(.all) { message in
//            print(message.payload)
//        }
//        userChanges.subscribe()
//    }
 
}




/*
 
 let json: [String: Any] = [
     "table": "Carbon",
     "type": "INSERT",
     "record": [
         "carbon_kg": "0.08",
         "created_at": "2023-08-19T15:44:59.769",
         "id": "64a0b2ee-0540-4afb-9f77-579031c5af7d",
         "name": "Logistics"
     ],
     "schema": "public",
     "commit_timestamp": "2023-08-19T15:45:00.958Z",
     "errors": NSNull(), // Or you can use nil
     "columns": [
         ["name": "id", "type": "uuid"],
         ["name": "created_at", "type": "timestamp"],
         ["name": "carbon_kg", "type": "float4"],
         ["name": "name", "type": "text"]
     ]
 ]

 // Accessing values from the dictionary
 if let table = json["table"] as? String,
    let type = json["type"] as? String,
    let record = json["record"] as? [String: Any],
    let schema = json["schema"] as? String,
    let commitTimestamp = json["commit_timestamp"] as? String,
    let columns = json["columns"] as? [[String: String]] {
     
     let carbonKG = record["carbon_kg"] as? String ?? ""
     let createdAt = record["created_at"] as? String ?? ""
     let id = record["id"] as? String ?? ""
     let name = record["name"] as? String ?? ""
     
     // Now you can use these extracted values as needed
     print("Table: \(table)")
     print("Type: \(type)")
     print("Schema: \(schema)")
     print("Commit Timestamp: \(commitTimestamp)")
     print("Carbon KG: \(carbonKG)")
     print("Created At: \(createdAt)")
     print("ID: \(id)")
     print("Name: \(name)")
     
     for column in columns {
         if let columnName = column["name"], let columnType = column["type"] {
             print("Column Name: \(columnName), Column Type: \(columnType)")
         }
     }
 }

 
 
 */


