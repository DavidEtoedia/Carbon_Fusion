//
//  flight_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/06/2023.
//

import SwiftUI


struct flight_screen: View {
    @EnvironmentObject private var flightVm: FlightViewModel
    @State private var showStatus = false
    @State  private var passenger: Int = 0
    @State private var isDestinationSheet = false
    @State private var isDepartureSheet = false
    @State private var selectedDeparture = IATAModel()
    @State private var selectedDestination = IATAModel()
    @State private var listState : [LegReq] = []

    // PICKer
    @State  private var initial: String = "Select"
    @FocusState private var isTextFieldFocused: Bool
    var ringValue: CGFloat = 1
    var body: some View {
        ZStack {

                VStack(alignment: .leading) {
                    BackButton()
                    
                    Space(height: 10)
                    
                    ScrollView {
                        Descriptions(title: "Passenger flights", subTilte: flight)
                        
                        Space(height: 50)
                      
                    CircleView(
                        carbonValue: String(
                            flightVm.result.value?.data?.attributes?.carbon_mt?.rounded(toDecimalPlaces: 1) ?? Double(0.0)
                        ), isLoading: flightVm.result.isLoading)
                        
                        VStack {
                            Text("Enter passengers")
                                .font(.system(size: 13))
                                .foregroundColor(.gray.opacity(0.8))
                            
                            TextField("passengers", value: $passenger, formatter: NumberFormatter())
                                .font(.system(size: 14))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .textContentType(.telephoneNumber)
                                .focused($isTextFieldFocused)
                                .frame(width: 120)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                       Spacer()
                                        Button("Done") {
                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                            //isTextFieldFocused = false
                                        }
                                    }
                                }
                            
                       
                            Space(height: 20)
                            HStack {
                                VStack(alignment:.leading){
                                    Text("Departure airport")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray.opacity(0.8))
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(width:130, height: 33)
                                        .cornerRadius(5)
                                        .overlay {
                                            HStack  {
                                                if(selectedDeparture.name.isEmpty){
                                                    Text(initial)
                                                        .font(.system(size: 13))
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .foregroundColor(.black.opacity(0.4))
                                                } else {
                                                    Text(selectedDeparture.name)
                                                        .font(.system(size: 13))
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .foregroundColor(.black.opacity(0.4))
                                                }
                                              
                                              
                                                Spacer()
                                                Image(systemName:"chevron.down")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 10)
                                                    .frame(width: 10)
                                                    .foregroundColor(Color.blue)
                                                
                                            }
                                            .padding([.leading, .trailing], 10)
                                            
                                        }
                                        .onTapGesture {
                                            isDepartureSheet = true
                                        }
                                        .sheet(isPresented: $isDepartureSheet) {
                                            DepartureSheet(isSheetPresent: $isDepartureSheet, selectedCode: $selectedDeparture)
                                        }
                                    
                                }

                                
                                VStack(alignment:.leading){
                                    Text("Destination airport")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray.opacity(0.8))
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .frame(width:130, height: 33)
                                        .cornerRadius(5)
                                        .overlay {
                                            HStack  {
                                                if(selectedDestination.name.isEmpty){
                                                    Text(initial)
                                                        .font(.system(size: 13))
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .foregroundColor(.black.opacity(0.4))
                                                } else {
                                                    Text(selectedDestination.name)
                                                        .font(.system(size: 13))
                                                        .lineLimit(1)
                                                        .truncationMode(.tail)
                                                        .foregroundColor(.black.opacity(0.4))
                                                }
                                                
                                                Spacer()
                                                Image(systemName:"chevron.down")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 10)
                                                    .frame(width: 10)
                                                    .foregroundColor(Color.blue)
                                                
                                            }
                                            .padding([.leading, .trailing], 10)
                                            
                                        }
                                        .onTapGesture {
                                            isDestinationSheet = true
                                        }
                                        .sheet(isPresented: $isDestinationSheet) {
                                            DestinationSheet(isSheetPresent: $isDestinationSheet, selectedCode: $selectedDestination)
                                        }
                                }
                                  
                            }
                            Spacer()
                                .frame(height: 40)
                            AppButton()
                                .onTapGesture {
                
                                    let val = LegReq(departureAirport: selectedDeparture.code, destinationAirport: selectedDestination.code)
                                    
                                    listState.append(val)
                                    
                                    flightVm.createFlight(passengers: passenger, legs: listState)
                                }
                         

                        }
                        .padding(.horizontal, 55)
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    }
                    .onTapGesture {
                        KeyboardHelper.closeKeyboard()
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .alert("Info", isPresented:  $flightVm.hasError, actions: {
                        HStack {
                            Button("Cancel", role: .cancel, action: {})
                            
                        }
                    }, message: {
                        Text(flightVm.result.error ?? "")
                    })
              
                    Spacer()

                }
            .navigationBarBackButtonHidden(true)
        
        }
        .background(.black)
        
        
        
    }
}

struct flight_screen_Previews: PreviewProvider {
    static var previews: some View {
        flight_screen()
            .environmentObject(FlightViewModel())
    }
}
