//
//  StateModel.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 08/07/2023.
//

import Foundation

struct StateModel: Codable,Hashable {
    var name: String = "Alabama"
    var abbreviation: String = "al"
    
    static let allState: [StateModel] = Bundle.main.decode(file: "unitedState.json")
    static let sampleStates: StateModel = allState[0]
}

