//
//  Ship_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 27/07/2023.
//

import SwiftUI

struct Ship_screen: View {
    @EnvironmentObject private var shipVm: ShipViewModel
    @State private var showStatus = false
    @State  private var distance: Int = 0
    @State  private var weight: Int = 0
    
    private var methods: [String] = ["truck", "ship", "train", "plane"]
    private var distanceUnit: [String] = ["km", "mi"]
    private var weightUnit: [String] = ["lb", "kg", "g", "mt"]
    @State private var selectedMethod  = "truck"
    @State private var selectedDistance  = "km"
    @State private var selectedWeight  = "kg"
    
    @FocusState private var isDistance: Bool
    @FocusState private var isWeight: Bool


    // PICKer
    var body: some View {
        ZStack {

                VStack(alignment: .leading) {
                    BackButton()
                    
                    Space(height: 10)
                    
                    ScrollView {
                        Descriptions(title: "Logistics and Shipping", subTilte: ship)
                        
                        Space(height: 50)
                      
                    CircleView(
                        carbonValue: String(
                            shipVm.result.value?.data?.attributes?.carbon_kg?.rounded(toDecimalPlaces: 1) ?? Double(0.0)
                        ), isLoading: shipVm.result.isLoading)
                        
                        VStack(alignment: .leading) {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Enter distance")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray.opacity(0.8))
                                    
                                    HStack {
                                        TextField("distance", value: $distance, formatter: NumberFormatter())
                                            .font(.system(size: 14))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .textContentType(.telephoneNumber)
                                            .focused($isDistance)
                                            .submitLabel(.next)
                                            .frame(width: 60)
                                          
                                        
                                        Picker("", selection: $selectedDistance) {
                                            ForEach(distanceUnit, id: \.self) { value in
                                                Text(value).tag(value)
                                            }
                                        }
                                    }
                                }
                                Spacer()
                                VStack(alignment: .leading){
                                    Text("Enter Weight")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray.opacity(0.8))
                                    
                                    HStack {
                                        TextField("Weight", value: $weight, formatter: NumberFormatter())
                                            .font(.system(size: 14))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .keyboardType(.numberPad)
                                            .textContentType(.telephoneNumber)
                                            .focused($isWeight)
                                            .submitLabel(.done)
                                            .frame(width: 60)
                                            .toolbar {
                                                ToolbarItemGroup(placement: .keyboard) {
                                                   Spacer()
                                                    Button("Done") {
                                                        KeyboardHelper.closeKeyboard()
                                                    }
                                                }
                                        }
                                        
                                        
                                        Picker("", selection: $selectedWeight) {
                                            ForEach(weightUnit, id: \.self) { value in
                                                Text(value).tag(value)
                                            }
                                        }
                                    }
                                }
                            
                            }
                            
                       
                            Space(height: 20)
                            
                            HStack {
                                VStack(alignment:.leading) {
                                    Text("Transport mode")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray.opacity(0.8))
                                    Menu {
                                        ForEach(methods, id: \.self) { option in
                                      
                                            Button {
                                                selectedMethod = option
                                            } label: {
                                                Text(option)
                                            }
                                        }
                                          } label: {
                                              HStack {
                                                  Text(selectedMethod)
                                                  Spacer()
                                                  VStack(spacing: 4) {
                                                      Image(systemName: "chevron.down")
                                                  }
                                              }
                                          }
                                          .padding(.horizontal, 10)
                                          .foregroundColor(Color(UIColor.label))
                                          .frame(height: 35)
                                          .background{
                                              Rectangle()
                                                  .foregroundColor(.white)
                                                  .cornerRadius(5)
                                      }
                                }
                            }
                               
                            Spacer()
                                .frame(height: 40)
                            AppButton()
                                .onTapGesture {
                                    shipVm.createShip(weightValue: weight, weightUnit: selectedWeight, distanceValue: distance, distanceUnit: selectedDistance, transportMethod: selectedMethod)
                                }
                         

                        }
                        .padding(.horizontal, 55)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    }
                    .onTapGesture {
                        KeyboardHelper.closeKeyboard()
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .alert("Info", isPresented:  $shipVm.hasError, actions: {
                        HStack {
                            Button("Cancel", role: .cancel, action: {})
                            
                        }
                    }, message: {
                        Text(shipVm.result.error ?? "")
                    })
              
                    Spacer()

                }
            .navigationBarBackButtonHidden(true)
        
        }
        .background(.black)

    }
}

struct Ship_screen_Previews: PreviewProvider {
    static var previews: some View {
        Ship_screen()
            .environmentObject(ShipViewModel())
    }
}
