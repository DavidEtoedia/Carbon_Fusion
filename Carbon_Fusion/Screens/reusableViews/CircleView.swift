//
//  CircleView.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 26/07/2023.
//

import SwiftUI

struct CircleView: View {
    var carbonValue: String
    var isLoading : Bool = false
    var ringValue: CGFloat = 1
    var body: some View {
        ZStack {
                           
            Circle()
                .inset(by: 2)
                .trim(from: 0.15, to: min(ringValue, 0.85))
                .stroke(
                    LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                )
                .frame(width: 220, height: 220)
                .rotationEffect(.degrees(90))
                .animation(.linear(duration: 1), value: ringValue)
            Circle()
                .inset(by: 2)
                .trim(from: 0.15, to: min(ringValue, 0.85))
                .stroke(
                    LinearGradient(colors: [Color.blue, Color.green], startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)
                )
                .frame(width: 180, height: 180)
                .rotationEffect(.degrees(90))
                .animation(.linear(duration: 1), value: ringValue)
            
            
            if (isLoading){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding(.vertical, 15)
            } else{
                Text(carbonValue)
                    .font(.custom(Font.climateCrisis, size: 30))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.1), radius: 20)
            }
        }
        .background(.black)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(carbonValue: "45")
    }
}
