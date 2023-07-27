//
//  Descriptions.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct Descriptions: View {
    var title: String
    var subTilte: String
    var body: some View {
        VStack{
            Text(title)
                .font(.custom(Font.climateCrisis, size: 33))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
            Space(height: 20)
            Text(subTilte)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal,30)
        }
    }
}

struct Descriptions_Previews: PreviewProvider {
    static var previews: some View {
        Descriptions(title: "water ", subTilte: "lool")
    }
}
