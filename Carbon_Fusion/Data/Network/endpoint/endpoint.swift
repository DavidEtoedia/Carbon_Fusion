//
//  endpoint.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 24/05/2023.
//

import Foundation


enum Endpoint: CustomStringConvertible {
    case createElectricity
    var description: String {
        switch self {
        case .createElectricity:
            return "https://www.carboninterface.com/api/v1/estimates"
        }
    }
}

enum ApiKey: CustomStringConvertible {
    case apiKey
    var description: String {
        switch self {
        case .apiKey:
            return "fL1P0SMxpidl6FclW2ONWg"
        }
    }
}
