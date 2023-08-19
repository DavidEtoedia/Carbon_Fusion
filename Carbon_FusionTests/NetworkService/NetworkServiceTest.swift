//
//  NetworkServiceTest.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 14/08/2023.
//

import XCTest
@testable import Carbon_Fusion

 class NetworkServiceTest: XCTestCase {
    private  var session: URLSession!
     private  var networkService = NetworkService()
    private  var url: URL!

    override func setUp() {
        url = URL(string: "https://reqres.in/carbon")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
     
     override func tearDown() {
         session = nil
         url = nil
     }
     
        func test_get_energy_response() async {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
         MockURLSessionProtocol.loadingHandler = {
             return (response, nil)
         }
         let energy = ElectricityReq(type: "Electricity", electricityUnit: "kwh", electricityValue: 10, country: "us", state: "fl")
         let electricityRes = ElectricityResponse()
         
          let encoded =  try? JsonMapper.encode(energy)
         
            networkService.request(session: session, method: .post, path: .createVehicle, body: encoded, completion: { (result: Result<ElectricityResponse, ApiError>) in
             
             switch result{
             case .success(let res):
                 XCTAssertEqual(res, electricityRes, "Returns the corresponding response")
             case .failure(_):
                 XCTAssert(false)
             }
             
         })
     }
     
     
     func test_returns_apiError() async {
         let response = HTTPURLResponse(url: url, statusCode: 400, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
         MockURLSessionProtocol.loadingHandler = {
             return (response, nil)
         }
         let energy = ElectricityReq(type: "Electricity", electricityUnit: "kwh", electricityValue: 10, country: "us", state: "fl")
         let expectation = XCTestExpectation(description: "Fetch data with failure")
         
          let encoded =  try? JsonMapper.encode(energy)
         
         networkService.request(session: session, method: .post, path: .createVehicle, body: encoded, completion: { (result: Result<ElectricityResponse, ApiError>) in
             switch result{
             case .success(_):
                 XCTAssert(false)
             case .failure(let err):
                 let networkingError = err as ApiError
                 XCTAssertEqual(err, networkingError.self)
             }
             expectation.fulfill()
         })
     }

}





