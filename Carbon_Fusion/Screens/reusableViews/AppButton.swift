//
//  AppButton.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct AppButton: View {
    var body: some View {
        Rectangle()
            .frame(height: 45)
            .foregroundColor(.blue)
            .cornerRadius(10)
            .padding(.horizontal, 50)
            .overlay {
                Text("Calculate")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.horizontal, 70)
                    .padding(.vertical, 10)
            }
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton()
    }
}
