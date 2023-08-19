//
//  RepositoryImpTest.swift
//  Carbon_FusionTests
//
//  Created by Inyene Etoedia on 14/08/2023.
//

import XCTest
@testable import Carbon_Fusion


final class RepositoryImpTest: XCTestCase {
    private  var session: URLSession!
    private  var url: URL!
    private  var httpRepository = HttpRepositoryImp()
    
    override func setUp() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
        url = URL(string: "https://carboninterface.com/api/v1/estimates")
    }
    
    override func tearDown() {
        session = nil
        url = nil
        super.tearDown()
    }
    
    // Test that create electricity is successful
    func test_create_electricity() {
        let mockData: Data = Data(mockString.utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!

        MockURLSessionProtocol.loadingHandler = {
            return (response, mockData)
        }

        let energy = ElectricityReq(type: "Electricity", electricityUnit: "kwh", electricityValue: 10, country: "us", state: "fl")
        let encoded =  try? JsonMapper.encode(energy)
        let expectation = XCTestExpectation(description: "Completion called")

        httpRepository.createEnergy(session: session, body: encoded) { (result: Result<ElectricityResponse, ApiError>) in
            
            defer { expectation.fulfill() }

            switch result {
            case .success(let res):
                XCTAssertEqual(res.datum?.attributes?.country, "United States", "Expected country to be 'United States'")
            case .failure(_):
                XCTAssertFalse(false)
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test that create electricity throws error
    func test_throw_create_electricity_error() {
        let invalidStatusCode = 500
        let response = HTTPURLResponse(url: url, statusCode: invalidStatusCode, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
        
        print("error code here \(response.statusCode)")

        MockURLSessionProtocol.loadingHandler = {
            return (response, nil)
        }

        let energy = ElectricityReq(type: "Electricity", electricityUnit: "kwh", electricityValue: 10, country: "us", state: "fl")
        let encoded =  try? JsonMapper.encode(energy)
        let expectation = XCTestExpectation(description: "Completion called")

        httpRepository.createEnergy(session: session, body: encoded) { (result: Result<ElectricityResponse, ApiError>)in
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case ApiError.errorCode(invalidStatusCode) = error {
                    XCTAssertEqual(error.errorDescription, "Internal server error")
                       expectation.fulfill() // The error is as expected, fulfill the expectation
                   } else {
                       XCTFail("Unexpected error: \(error)")
                   }
            }
        }
        
       wait(for: [expectation], timeout: 10) // Wait for the expectation to be fulfilled
    }
    
    
    // Test that create flight is successful
    func test_create_flight() {
        let mockData: Data = Data(mockFlight.utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!

        MockURLSessionProtocol.loadingHandler = {
            return (response, mockData)
        }

        let flight = FlightReq(type: "flight", passengers: 10, legs: [LegReq(departureAirport: "SFO", destinationAirport: "YYZ")])
        let encoded =  try? JsonMapper.encode(flight)
        let expectation = XCTestExpectation(description: "Completion called")

        httpRepository.createFlight(session: session, body: encoded) { (result: Result<FlightResponseModel, ApiError>) in
            
            switch result {
            case .success(let res):
                XCTAssertEqual(res.data?.id, "d60edacc-cf6c-4da7-b5de-c538de4ce5ee", "Expected length to be '1'")
            case .failure(_):
                XCTAssertFalse(false)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    // Test that create flight throws an error
    func test_throw_create_flight_error() {
        let invalidStatusCode = 422
        let response = HTTPURLResponse(url: url, statusCode: invalidStatusCode, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
        
        print("error code here \(response.statusCode)")

        MockURLSessionProtocol.loadingHandler = {
            return (response, nil)
        }

        let flight = FlightReq(type: "flight", passengers: 10, legs: [LegReq(departureAirport: "SFO", destinationAirport: "YYZ")])
        let encoded = try? JsonMapper.encode(flight)
        let expectation = XCTestExpectation(description: "Completion called")

        httpRepository.createFlight(session: session, body: encoded) { (result: Result<FlightResponseModel, ApiError>) in
            
            defer { expectation.fulfill() }
            
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case ApiError.errorCode(invalidStatusCode) = error {
                   } else {
                       XCTFail("Unexpected error: \(error)")
                   }
            }
        }
        
       wait(for: [expectation], timeout: 10) // Wait for the expectation to be fulfilled
    }
    
    
    func test_create_logistics() {
        // Given
        let mockDatas: Data = Data(mockLogistics.utf8)
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
        MockURLSessionProtocol.loadingHandler = { return (response, mockDatas) }

        let logistics = ShippingReq(type: "shipping", weightValue: 200, weightUnit: "kg", distanceValue: 100, distanceUnit: "km", transportMethod: "plane")
        let encoded = try? JsonMapper.encode(logistics)
        let expectation = XCTestExpectation(description: "Completion called")

        // When
        httpRepository.createShipping(session: session, body: encoded) { result in
            defer { expectation.fulfill() }
            switch result {
            case .success(let res):
                XCTAssertEqual(res.data?.attributes?.transport_method, "plane", "Expected ID to match")
            case .failure(_):
                XCTAssertFalse(false)
            }
        }
        wait(for: [expectation], timeout: 10.0)

    }

      
    func test_create_logistics_throws_error() {
        let invalidStatusCode = 429
        // Given
        let response = HTTPURLResponse(url: url, statusCode: invalidStatusCode, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
        MockURLSessionProtocol.loadingHandler = { return (response, nil) }

        let logistics = ShippingReq(type: "shipping", weightValue: 200, weightUnit: "kg", distanceValue: 100, distanceUnit: "km", transportMethod: "plane")
        let encoded = try? JsonMapper.encode(logistics)
        let expectation = XCTestExpectation(description: "Completion called")

        // When
        httpRepository.createShipping(session: session, body: encoded) { result in
            defer { expectation.fulfill() }
            switch result {
            case .success(_):
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                if case ApiError.errorCode(invalidStatusCode) = error {
                    XCTAssertEqual(error.errorDescription, "Too many request")

                   } else {
                       XCTFail("Unexpected error: \(error)")
                   }
            }
        }
        wait(for: [expectation], timeout: 10.0)

    }

      

}





let mockString =
 """
 {
     "data": {
         "id": "example_id",
         "type": "example_type",
         "attributes": {
             "country": "United States",
             "state": "California",
             "electricity_unit": "kWh",
             "electricity_value": 123.45,
             "estimated_at": "2023-08-14T12:34:56Z",
             "carbon_g": 500,
             "carbon_lb": 1.1023,
             "carbon_kg": 0.5,
             "carbon_mt": 0.0005
         }
     }
 }
 """



let mockFlight =
 """
 {
   "data": {
     "id": "d60edacc-cf6c-4da7-b5de-c538de4ce5ee",
     "type": "estimate",
     "attributes": {
       "passengers": 2,
       "legs": [
         {
           "departure_airport": "SFO",
           "destination_airport": "YYZ"
         },
       ],
       "estimated_at": "2020-07-24T02:25:50.837Z",
       "carbon_g": 1077098,
       "carbon_lb": 2374,
       "carbon_kg": 1077,
       "carbon_mt": 1,
       "distance_unit": "km",
       "distance_value": 7454.15
     }
   }
 }
 """

let mockLogistics =
"""
{
   "data":{
      "id":"4746e4ba-6605-4acc-802b-fd229a9503b4",
      "type":"estimate",
      "attributes":{
         "distance_value":0.0,
         "weight_unit":"string",
         "transport_method":"plane",
         "weight_value":0.0,
         "distance_unit":"string",
         "estimated_at":"string",
         "carbon_g":0,
         "carbon_lb":0.0,
         "carbon_kg":0.0,
         "carbon_mt":0.0
      }
   }
}
"""

/*
 
 {
   "data": {
     "id": "4746e4ba-6605-4acc-802b-fd229a9503b4",
     "type": "estimate",
     "attributes": {
       "distance_value": "2000.0",
       "distance_unit": "km",
       "weight_value": "200.0",
       "weight_unit": "g",
       "transport_method": "0",
       "estimated_at": "2020-07-31T13:00:04.446Z",
       "carbon_g": 25,
       "carbon_lb": 0.06,
       "carbon_kg": 0.03,
       "carbon_mt": 0.0
     }
   }
 }
 
 
 
 */







