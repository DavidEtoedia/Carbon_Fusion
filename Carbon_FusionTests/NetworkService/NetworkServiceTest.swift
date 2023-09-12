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
     private  var request: URLRequest!

    override func setUp() {
        url = URL(string: "https://reqres.in/carbon")
        request = URLRequest(url: URL(string: "https://example.com")!)
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
     
     override func tearDown() {
         session = nil
         url = nil
     }
     
     func test_get_energy_response() async {
         let mockData: Data = Data(mockString.utf8)
         let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
         MockURLSessionProtocol.loadingHandler = {
             return (response, mockData)
         }
         
         let expectation = XCTestExpectation(description: "Request completion")
         
         networkService.request(session: session, method: .get, path: .createVehicle, body: nil) { (result: Result<ElectricityResponse, ApiError>) in
             switch result {
             case .success(let decodedData):
                 // Add your assertions for a successful request here
                 XCTAssertEqual(decodedData.datum?.id,"example_id")
             case .failure(let error):
                 XCTFail("Request failed with error: \(error)")
             }
             
             expectation.fulfill()
         }
         
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





