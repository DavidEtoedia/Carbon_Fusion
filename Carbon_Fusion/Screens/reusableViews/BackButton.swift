//
//  BackButton.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var dismiss
    var body: some View {
        HStack {
            Image(systemName: "chevron.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 17, height: 17)
                .foregroundColor(.white)
              
            Text("Back")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal,5)
        }
        .padding(.horizontal, 10)
        .onTapGesture {
            dismiss.wrappedValue.dismiss()
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
