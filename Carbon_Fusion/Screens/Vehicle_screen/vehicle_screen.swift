//
//  vehicle_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 25/06/2023.
//

import SwiftUI

struct vehicle_screen: View {
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 190
    private let minTemperature: CGFloat = 4
    @State  private var number: String = ""
    @State private var currentTemperature: CGFloat = 50
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    // State
    @State private var selectedOption = "mi"
    @State  private var inputValue: String = ""
    @State  private var vehicles: String = "Select Vehicle"
    var degree: CGFloat = 34
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    var body: some View {
        VStack {
            Space(height: 10)
            Text("Vehicle CO2 Estimates")
                .font(.custom(Font.climateCrisis, size: 33))
                .foregroundColor(.white)
            Space(height: 40)
            Text(vehicle)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal,40)
            Space(height: 50)
            ZStack {
                Image("car")
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
            
          
            VStack {
                HStack {
                    VStack(alignment:.leading) {
                        Text("Enter distance")
                            .font(.system(size: 13))
                            .foregroundColor(.gray.opacity(0.8))
                        ZStack {
                            TextField("", value: $inputValue, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .textContentType(.telephoneNumber)
                                .onReceive(inputValue.publisher.collect()) {
                                    self.inputValue = String($0.prefix(5))
                              }
                                .padding(.trailing,5)
                                .frame(width: 120)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            KeyboardHelper.closeKeyboard()
                                        }
                                    }
                                }
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                            
                            HStack {
                                Space(width: 80)
                                Text("mi")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                            .padding(.trailing, 8) // Adjust the padding as needed
                        }
                    }

                    
                    VStack(alignment:.leading){
                        Text("Select vehicle")
                            .font(.system(size: 13))
                            .foregroundColor(.gray.opacity(0.8))
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width:130, height: 33)
                            .cornerRadius(5)
                            .overlay {
                                HStack  {
                                    Text(vehicles)
                                        .font(.system(size: 13))
                                        .foregroundColor(.black.opacity(0.4))
                                  
                                    
                                    Image(systemName:"chevron.down")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10)
                                        .frame(width: 10)
                                        .foregroundColor(Color.blue)
                                    
                                }
                                .padding([.leading, .trailing], 5)
                                
                            }
                    }
                      
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            
     
          Space(height: 40)

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

struct vehicle_screen_Previews: PreviewProvider {
    static var previews: some View {
        vehicle_screen()
    }
}
