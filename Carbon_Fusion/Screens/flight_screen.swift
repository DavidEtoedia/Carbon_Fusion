//
//  flight_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/06/2023.
//

import SwiftUI

struct flight_screen: View {
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 190
    private let minTemperature: CGFloat = 4
    @State  private var number: String = ""
    @State private var currentTemperature: CGFloat = 50
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    // PICKer
    @State private var selectedOption = "mi"
    private let options = ["mi", "km"]
    var degree: CGFloat = 34
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    var body: some View {
        VStack {
            Space(height: 10)
            Text("Passenger flights")
                .font(.custom(Font.climateCrisis, size: 33))
                .foregroundColor(.white)
            Space(height: 40)
            Text(flight)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal,40)
            Space(height: 50)
            ZStack {
                Image("plane")
                    .resizable()
                    .scaledToFit()
                    .padding(5)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .offset(y: -50)
                               
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
                Text("49")
                    .font(.custom(Font.climateCrisis, size: 50))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.1), radius: 20)
            }
            
          
            HStack {
                TextField("Enter value", text: $number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .textContentType(.telephoneNumber)
                            .padding()
                            .frame(width: 150)
                Picker( "value", selection: $selectedOption) {
                    ForEach(options, id: \.self) { value in
                        Text(value)
                            .foregroundColor(.white)
                    }
                }
                .pickerStyle(.menu)
            }
         

            Button {
                
            } label: {
                Text("Calculate")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 70)
                    .padding(.vertical, 10)

            }
            .background(Rectangle().foregroundColor(.blue).cornerRadius(10))
            

        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
        .background(.black)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct flight_screen_Previews: PreviewProvider {
    static var previews: some View {
        flight_screen()
    }
}
