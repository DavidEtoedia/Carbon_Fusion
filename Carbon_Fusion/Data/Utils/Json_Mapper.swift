//
//  Json_Mapper.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


struct JsonMapper{
    
    
    static  func decode<T: Decodable>( type: T.Type , data : Data) throws -> T {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do{
            let decoded = try decoder.decode(type, from: data)
            return decoded
        }
        catch {
            throw error
        }
        
    }
    
    static func decoded<T: Decodable>(_ data: Data) throws -> T {
        // 1. Create a decoder
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // 2. Create a property for the decoded data
        return try decoder.decode(T.self, from: data)
    }
    
//    static func decode<T: Decodable>(_ data: Data) throws -> T {
//        // 1. Create a decoder
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//        // 2. Create a property for the decoded data
//        return try decoder.decode(T.self, from: data)
//    }
    
    static func encode<T: Encodable>(_ data: T) throws -> Data {
           // 1. Create an encoder
           let encoder = JSONEncoder()
           encoder.keyEncodingStrategy = .convertToSnakeCase
           
           // 2. Create a property for the encoded data
           return try encoder.encode(data)
       }
       
    
}
