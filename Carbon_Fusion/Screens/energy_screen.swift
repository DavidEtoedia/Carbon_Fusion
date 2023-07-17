//
//  energy_screen.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 18/06/2023.
//

import SwiftUI

struct energy_screen: View {
    @EnvironmentObject private var energyVm: EnergyViewModel
    @Environment(\.presentationMode) var dismiss
    
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 190
    private let minTemperature: CGFloat = 4
    @State  private var inputValue: Int = 0
    @State private var currentTemperature: CGFloat = 50
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    @State private var isSheetPresented = false
    
    // State
    
     var state: [StateModel] = StateModel.allState
    @State private var selectedState = StateModel()
    @State private var selectedValue : StateModel?
    @State var alphaCode: String = "AL"

    var degree: CGFloat = 34
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    var body: some View {
        VStack(alignment: .leading) {
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
            Space(height: 30)
            ScrollView {
              
                Text("Electricity Consumption")
                    .font(.custom(Font.climateCrisis, size: 33))
                    .foregroundColor(.white)
                    .padding(.bottom, 25)
            
                Text(energy)
                    .font(.system(size: 15))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal,10)
                    .padding(.bottom, 25)
                
             
                ZStack {
                    Image("light")
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
                    
                    if(energyVm.result.isLoading){
                  
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white)) // Set the color here
                       
                    } else {
                        Text(String(
                            energyVm.result.value?.datum?.attributes?.carbon_kg ?? 0.0
                        ))
                            .font(.custom(Font.climateCrisis, size: 40))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.1), radius: 20)
                    }
                   
                }
                
                VStack(alignment:.leading){
                    HStack {
                        TextField("Enter value", value: $inputValue, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .textContentType(.telephoneNumber)
                            .padding(.trailing,5)
                            .frame(width: 120)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        closeKeyboard()
                                    }
                                }
                            }

                            .ignoresSafeArea(.keyboard, edges: .bottom)
                        Text("kwh")
                            .font(.system(size: 20))
                            .foregroundColor(.gray.opacity(0.8))
                          
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    Space(height: 20)
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width:180, height: 35)
                        .cornerRadius(5)
                        .overlay {
                            HStack  {
                                Text(selectedValue?.name ?? "Select country" )
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                Spacer()
                                
                                Image(systemName:"chevron.down")
                                    .foregroundColor(Color.blue)
                                
                            }
                            .padding([.leading, .trailing], 5)
                            
                        }
                        .onTapGesture {
                            isSheetPresented = true
                        }
                        .sheet(isPresented: $isSheetPresented) {
                            SheetView(isSheetPresent: $isSheetPresented, selectedState: $selectedValue)
                        }
                }
              
                
               Spacer()
                    .frame(height: 50)
                Button {
                    if((inputValue == .zero) || (selectedValue == nil) ){
                        return
                    }
                    else{
                        
                        energyVm.calEnergy(value: inputValue, state: selectedValue?.abbreviation.lowercased() ?? "AL")
                       // closeKeyboard()
                    }
                } label: {
                    Text("Calculate")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 70)
                        .padding(.vertical, 10)
                        .background(Rectangle().foregroundColor(.blue).cornerRadius(10))
                
                }

            }
            .padding(.horizontal, 30)
            .onTapGesture {
                closeKeyboard()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            .alert("Info", isPresented:  $energyVm.hasError, actions: {
                HStack {
                    Button("Cancel", role: .cancel, action: {})
                    
                }
            }, message: {
                Text(energyVm.result.error ?? "")
            })
        
        }
        .background(.black)
        .navigationBarBackButtonHidden(true)
    }
    
    
    
    
    //MARK: Close keyboard
    func closeKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}

struct energy_screen_Previews: PreviewProvider {
    static var previews: some View {
//
        let _ = ServiceContainer.register(type: HttpRepository.self, HttpRepositoryImp())
        energy_screen()
            .environmentObject(EnergyViewModel())
    }
}


