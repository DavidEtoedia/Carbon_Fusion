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

extension Bundle {
    func decode<T: Decodable>(file: String)  -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
           fatalError("could not find file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("could not load file in project")
        }
        
        guard let result = try? JsonMapper.decode(type: T.self, data: data) else {
            fatalError("could not decode data")
        }
        return result
        
    }
}
