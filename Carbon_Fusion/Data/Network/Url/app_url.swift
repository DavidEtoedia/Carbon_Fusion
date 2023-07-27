//
//  app_url.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    // Add more HTTP methods as needed
}


enum Path: String {
    case estimate = "/estimates"
    case createVehicle = "/vehicle_makes"
}







