//
//  SupabaseRepository.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 01/09/2023.
//

import XCTest
@testable import Carbon_Fusion

final class SupabaseRepositoryTest: XCTestCase {

    private  var supaBase: MockSupaBaseManagerProtocol!
    private var supabaseFailure: MockSupaBaseFailureService!
    
    override func setUp() {
        
        supaBase = MockSupaBaseMangerImpl()
        supabaseFailure = MockSupaBaseFailureService()
        
        
    }
    
    override func tearDown() {
        supaBase = nil
        supabaseFailure = nil
        super.tearDown()
    }
    
    
    func test_Request() async throws {
        let reqBody = DataModel(carbonKg: 0.4, createdAt: "", name: "Energy")
        let tableName = "Carbon"
        do{
            
            let response: DataModel? = try await supaBase.request(reqBody: reqBody, table: tableName)
            XCTAssertNotNil(response)
        }
        catch{
            XCTFail("Invalid response")
        }
    }
    
    func test_errorCode() async throws {
        let reqBody = DataModel(carbonKg: 0.4, createdAt: "", name: "Energy")
        let tableName = "Carbon"
        do{
            
            let _: DataModel? = try await supabaseFailure.request(reqBody: reqBody, table: tableName)
            XCTFail("Expected failure, but got success")
        }
        catch{
            if case ApiError.errorCode(400) = error {
               } else {
                   XCTFail("Unexpected error: \(error)")
               }
        }
    }

}





