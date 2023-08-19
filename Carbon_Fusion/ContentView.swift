//
//  ContentView.swift
//  Carbon_Fusion
//
//  Created by Inyene Etoedia on 16/05/2023.
//

import SwiftUI



struct Space: View {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var body: some View {
        Spacer()
            .frame(width: width, height: height)
    }
}

struct ContentView: View {
    @EnvironmentObject private var energyVm: EnergyViewModel
    @EnvironmentObject private var flightVm: FlightViewModel
    @EnvironmentObject private var shipVm: ShipViewModel
    @EnvironmentObject private var supabaseVM: SupbaseViewModel
    
   

    // States
    @State private var path = NavigationPath()
    private let outerDialSize: CGFloat = 200
    private let innerDialSize: CGFloat = 172
    private let setpointSize: CGFloat = 15
    private let ringSize: CGFloat = 220
    private let minTemperature: CGFloat = 4
    private let maxTemperature: CGFloat = 30
    @State private var currentTemperature: CGFloat = 0
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    @State private var units : [String] = ["Kg", "mt", "lb"]
    @State private var selectedUnit = "Kg"
    //Circle Timer
    @State private var borderanim1: CGFloat = 0.0
    let timer1 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @State private var borderanim2: CGFloat = 0.0
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    //Gradient
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color.orange, Color.pink]),
        center: .center,
        startAngle: .degrees(180),
        endAngle: .degrees(0))


//    private let gradient2 = AngularGradient(
//        gradient: Gradient(colors: [Color.purple, Color.blue]),
//        center: .center,
//        startAngle: .degrees(180),
//        endAngle: .degrees(0))
    
    var degree: CGFloat = 0
    var ringValue: CGFloat {
        currentTemperature / 50
    }
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack{
                
                HStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Text("Hi David, you have emitted \(String( carbonFt(value: selectedUnit)))")
                        .font(.system(size:15))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                     Spacer()
                    Picker("Selection", selection: $selectedUnit) {
                        ForEach(units, id: \.self) { value in
                            Text(value).tag(value)
                        }
                    }
                    .accessibilityIdentifier("select unit")
                    
                
                }
                .frame(maxWidth: .infinity, alignment:  .leading)

                ZStack(alignment:.center) {
                    ZStack{
                        Circle()
                            .stroke(Color.gray, lineWidth: 15).opacity(0.3)
                            .frame(width: 220, height: 220, alignment: .center)
                        
                        
                        
                        Circle()
                            .trim( from: 0, to:
//                                    CGFloat( (supabaseVM.carbonFTP ?? 0.0) / 100 )

                                   self.borderanim1

                            )
                            .stroke(gradient, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                            .frame(width: 220, height: 220, alignment: .center)
                            .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
                            .rotationEffect(.degrees(180))
                        
                            .onReceive(timer1) { _ in
//                                withAnimation {
//                                    guard self.borderanim1 < 0.65 else { return }
//                                    self.borderanim1 += 0.65
//
//                                }
                            }
                        
                        
                    }
                    
                  
//                    Circle()
//                        .stroke(Color.gray, lineWidth: 15).opacity(0.3)
//                        .frame(width: 200, height: 200, alignment: .center)
                    
//                    Circle()
//                        .trim( from: 0, to: self.borderanim2)
//                        .stroke(gradient2, style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                        .frame(width: 200, height: 200, alignment: .center)
//                        .rotationEffect(.degrees(-270))
//                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
//                        .rotationEffect(.degrees(-90))
//                        .onReceive(timer2) { _ in
//                            withAnimation {
//                                guard self.borderanim2 < 0.7 else { return }
//                                self.borderanim2 += 0.7
//                            }
//                        }
//                    Circle()
//
//                        .stroke(Color.gray, lineWidth: 15).opacity(0.3)
//                        .frame(width: 140, height: 140, alignment: .center)
                    
//                    Circle()
//                        .trim( from: 0, to:
//                                CGFloat( (energyVm.electricity.datum?.attributes?.carbon_kg ?? 0.0) / 2 )
//
//                               // self.borderanim2
//
//                        )
//                        .stroke(gradient2, style: StrokeStyle(lineWidth: 15, lineCap: .round))
//                        .frame(width: 140, height: 140, alignment: .center)
//                        .rotationEffect(.degrees(-120))
//                        .shadow(color: .black, radius: 5, x: 0.0, y: 0.0)
//                        .rotationEffect(.degrees(-90))
//                        .onReceive(timer2) { _ in
//                            withAnimation {
//                                guard self.borderanim2 < 0.7 else { return }
//                                self.borderanim2 += 0.7
//                            }
//
//                        }
                    VStack(spacing:10) {
                        Text(String( carbonFt(value: selectedUnit)))
                            .font(.custom(Font.climateCrisis, size: 40))
                        .foregroundColor(.white)
                  
                            Text("CO2e/\(selectedUnit)")
                                .font(.system(size:20))
                            .foregroundColor(.white)
                            .offset(y: 6)
                        
                        Text("Total emission")
                            .font(.system(size:14))
                            .foregroundColor(.white.opacity(0.5))
                        .offset(y: 6)
                      
                    }
                }
                .frame(width: 300, height: 260)
                .padding(.horizontal)
                
            
                
                NavigationLink {
                    HistoryScreen(list: supabaseVM.result.value ?? [])
                } label: {
                    Text("View History")
                        .font(.system(size:20))
                        .foregroundColor(.blue)
                }

              
                
                Space(height: 50)
                Text("Activities")
                    .font(.system(size:20))
                    .foregroundColor(.white)
                    .frame(maxWidth:.infinity, alignment:.leading)
                Space(height: 20)
              // MARK: Containers -------------->
               
                NavigationLink {
                    energy_screen()
                } label: {
                    CarbonCard(name: "Energy", value:String(  energyVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "light", isLoading: energyVm.data.isLoading)
                }
                .accentColor(.clear)
                .accessibilityIdentifier("Energy")
           

                NavigationLink {
                    Ship_screen()
                } label: {
                    CarbonCard(name: "logistics", value: String(  shipVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "ship", isLoading: shipVm.data.isLoading)
                }
                .accentColor(.clear)
                .accessibilityIdentifier("logistics")
                
                NavigationLink {
                    flight_screen()
                } label: {
                    CarbonCard(name: "Flights", value: String(  flightVm.data.value?.carbonKg.rounded(toDecimalPlaces: 1) ?? 0.0), image: "plane", isLoading: flightVm.data.isLoading)
                }
                .accentColor(.clear) // Set the accent color to clear
                .accessibilityIdentifier("Flights")

                    
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 25)
            .background(.black)
            .edgesIgnoringSafeArea(.bottom)
            .edgesIgnoringSafeArea(.top)
            .alert("Error", isPresented: $supabaseVM.hasError, actions: {
                Button("Ok", role: .cancel, action: {})
            }, message: {
                Text("An Error occured")
            })
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // Code you want to execute after the delay
                    withAnimation {
//                        guard self.borderanim1 < 0.65 else { return }
                        self.borderanim1 =
                        CGFloat( (supabaseVM.carbonFTP) / 100)
                    }
                }
           
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    @ViewBuilder
    func CarbonCard(name: String, value: String, image: String, isLoading: Bool)-> some View {
        
        Rectangle()
            .cornerRadius(5)
            .frame(height: 90)
            .foregroundColor(Color.gray.opacity(0.2))
            .overlay {
                HStack {
                    VStack(alignment: .leading) {
                        
                        Label {
                            Text(name)
                                .font(.system(size:20))
                                .foregroundColor(.white)
                        } icon: {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .padding(5)
                                .foregroundColor(.white)
                                .frame(width: 35, height: 35)
                        }
                        
                     
                    }
                    Spacer()
                    HStack {
                        
                        if(isLoading){
                            ProgressView()
                                .tint(.white)
                                .scaleEffect(1)
                                .padding(.trailing, 7)
                        }else{
                            
                            Text(value)
                                .font(.custom(Font.climateCrisis, size: 40))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.1), radius: 20)
                        }
                        
                        
                        Text("Kg")
                            .font(.custom(Font.climateCrisis, size: 15))
                            .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.1), radius: 20)
                    }
                }
                .frame(maxWidth: .infinity, alignment:  .leading)
                .padding(.leading, 10)
                .padding(.trailing, 20)
            }
    }
    
    
    
    
    func carbonFt(value: String) -> Double {
        switch value {
        case "kg":
            return  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1)
        case "mt":
          let result =  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1) / 1000
            return  result.rounded(toDecimalPlaces: 1)
        case "lb":
           let result =  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1) * 2.20462
            
            return result.rounded(toDecimalPlaces: 1)
        default:
            return  supabaseVM.carbonFTP.rounded(toDecimalPlaces: 1)
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(EnergyViewModel())
            .environmentObject(FlightViewModel())
            .environmentObject(ShipViewModel())
            .environmentObject(SupbaseViewModel())
    }
}
