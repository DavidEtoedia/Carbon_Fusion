//
//  StateModel.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 08/07/2023.
//

import Foundation

struct IATAModel: Codable,Hashable {
    var code: String = ""
    var name: String = ""
    var country: String = ""
    
    

    static let allCode: [IATAModel] = Bundle.main.decode(file: "iataCode.json")
    static let sampleCodes: IATAModel = allCode[0]
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
