//
//  http_repository_imp.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 28/06/2023.
//

import Foundation


protocol ApiRepository {
    
    func createEnergy<T: Codable> (body: T, completion: @escaping (Result<ElectricityResponse, ApiError>) -> Void)
    func createFlight<T: Codable> ( body: T, completion: @escaping (Result<FlightResponseModel, ApiError>) -> Void)
    func createShipping<T: Codable> (body: T, completion: @escaping (Result<ShipResponseModel, ApiError>) -> Void)
    
}



    
    
    


