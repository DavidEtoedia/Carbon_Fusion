//
//  SupbaseRepositorySuccessTest.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 01/09/2023.
//

import XCTest
@testable import Carbon_Fusion

final class SupbaseRepositorySuccessTest: XCTestCase {
    
    private  var supabaseRepo: SupabaseRepository!
    
    override  func setUp() {
        supabaseRepo = MockSupaBaseRepository()
    }
    override  func tearDown() {
        supabaseRepo = nil
    }
    
    
    func test_create_to_supabase() async{
        let result =  try? await  supabaseRepo.getRequest(table: "Carbon")
        
        XCTAssertEqual(result?.count, 2)
    }
  

}
